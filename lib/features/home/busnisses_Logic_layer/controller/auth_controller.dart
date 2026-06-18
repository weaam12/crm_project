import 'package:crm_project/features/home/data layer/models/TenantMeModel.dart';
import 'package:crm_project/features/home/data layer/source/auth_api_service.dart';
import 'package:crm_project/features/home/data%20layer/models/platformModel.dart'
    hide Permission;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();
  final GetStorage _box = GetStorage();

  // ================= UI STATE =================
  var isTenantMode = true.obs;
  var isLoading = false.obs;

  // ================= USER INFO =================
  var userName = ''.obs;
  var userDetail = ''.obs;
  var workspaceName = ''.obs;

  // ================= RBAC (IMPORTANT) =================
  var permissionsMap = <String, List<String>>{}.obs;
  RxString userStatus = ''.obs;
  RxString profileName = ''.obs;
  RxInt permissionsCount = 0.obs;

  // =====================================================
  // LOGIN PLATFORM
  // =====================================================
  Future<void> loginPlatform(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('', 'Please fill in all fields');
      return;
    }

    try {
      isLoading.value = true;

      final response = await _apiService.loginAsPlatform(
        email: email,
        password: password,
      );

      print("LOGIN RESPONSE: ${response.data}");

      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        final tokenType = response.data['token_type'];

        await _box.write('access_token', token);
        await _box.write('token_type', tokenType);
        await _box.write('is_logged_in', true);

        print("Before getPlatformMe");

        await getPlatformMe(token);

        print("After getPlatformMe");

        Get.snackbar('Success', 'Platform login successful');
      } else {
        Get.snackbar('Error', 'Status not 200');
      }
    } catch (e, stack) {
      print("LOGIN ERROR: $e");
      print(stack);

      Get.snackbar('Error', 'Platform login failed');
    } finally {
      isLoading.value = false;
    }
  }

  // =====================================================
  // LOGIN TENANT
  // =====================================================
  Future<void> loginTenant(String identifier, String password) async {
    if (identifier.isEmpty || password.isEmpty) {
      Get.snackbar('Warning', 'Please fill in all fields');
      return;
    }

    try {
      isLoading.value = true;

      final response = await _apiService.loginAsTenant(
        identifier: identifier,
        password: password,
      );

      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        final tokenType = response.data['token_type'];

        await _box.write('access_token', token);
        await _box.write('token_type', tokenType);
        await _box.write('is_logged_in', true);

        await getTenantMe(token);

        Get.snackbar('Success', 'Tenant login successful');
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Login Failed',
          message: e.toString(),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPlatformMe(String token) async {
    print("Entered getPlatformMe");
    final response = await _apiService.getPlatformMe(token: token);
    print("STATUS = ${response.statusCode}");
    print("BODY = ${response.data}");
    if (response.statusCode == 200) {
      final platformModel = PlatformMeModel.fromMap(response.data);
      print("ME RESPONSE = ${response.data}");
      userName.value = platformModel.user.name;
      userDetail.value = platformModel.user.email;
      workspaceName.value = 'Central Platform';
      userStatus.value = platformModel.user.status;

      if (platformModel.user.profiles.isNotEmpty) {
        profileName.value = platformModel.user.profiles.first.name;
      }

      permissionsCount.value = platformModel.user.permissions.length;
      Get.offAllNamed('/platform-dashboard');
    }
  }

  // =====================================================
  // GET TENANT ME
  // =====================================================
  Future<void> getTenantMe(String token) async {
    try {
      final response = await _apiService.getTenantMe(token: token);

      if (response.statusCode == 200) {
        final tenantModel = TenantMeModel.fromMap(response.data);

        // ================= USER INFO =================
        userName.value = tenantModel.user?.name ?? 'User';
        userDetail.value = tenantModel.user?.username ?? '';
        workspaceName.value = tenantModel.tenant?.name ?? 'Workspace';

        // ================= RBAC BUILD =================
        setPermissions(tenantModel.permissions ?? []);

        Get.offAllNamed('/tenant-dashboard');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load tenant data: $e');
    }
  }

  // =====================================================
  // RBAC BUILDER (CORE LOGIC)
  // =====================================================
  void setPermissions(List<Permission> perms) {
    final map = <String, List<String>>{};

    for (final p in perms) {
      final module = p.module ?? '';
      final action = p.action ?? '';

      if (module.isEmpty || action.isEmpty) continue;

      map.putIfAbsent(module, () => []);
      map[module]!.add(action);
    }

    permissionsMap.assignAll(map);
  }

  // =====================================================
  // PERMISSION CHECKER (USE IN UI)
  // =====================================================
  bool can(String module, String action) {
    return permissionsMap[module]?.contains(action) == true;
  }
}
