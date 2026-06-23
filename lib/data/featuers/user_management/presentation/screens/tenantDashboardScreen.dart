import 'package:crm_project/core/theme/app_tokens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_project/data/featuers/user_management/presentation/controllers/auth_controller.dart';

class TenantDashboardScreen extends StatelessWidget {
  const TenantDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 700;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Obx(
          () => Text(
            controller.workspaceName.value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppTokens.fontFamily,
            ),
          ),
        ),
      ),

      // ================= DRAWER =================
      drawer: _buildDrawer(controller),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHero(controller),
            const SizedBox(height: 25),
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildActions(controller, isTablet),
          ],
        ),
      ),
    );
  }

  // ================= HERO =================
  Widget _buildHero(LoginController controller) {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [AppTokens.primary900, AppTokens.primary600],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Welcome 👋", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Text(
              controller.userName.value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              controller.workspaceName.value,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  // ================= ACTIONS =================
  Widget _buildActions(LoginController controller, bool isTablet) {
    return Obx(() {
      final actions = <_ActionItem>[];

      // USERS MODULE
      if (controller.can('users', 'list')) {
        actions.add(
          _ActionItem(
            title: "Employees",
            icon: Icons.people,
            color: Colors.blue,
            route: '/tenant-employees',
          ),
        );
      }

      if (controller.can('users', 'create')) {
        actions.add(
          _ActionItem(
            title: "Add Employee",
            icon: Icons.person_add,
            color: Colors.green,
            route: '/tenant-add-employee',
          ),
        );
      }

      // DASHBOARD MODULE
      if (controller.can('dashboard', 'view')) {
        actions.add(
          _ActionItem(
            title: "Reports",
            icon: Icons.bar_chart,
            color: Colors.purple,
            route: '/tenant-analytics',
          ),
        );
      }

      if (actions.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("No actions available for your current permissions."),
          ),
        );
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: actions.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 4 : 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) {
          final item = actions[index];

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Get.toNamed(item.route),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: item.color.withOpacity(0.1),
                      child: Icon(item.icon, color: item.color),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  // ================= DRAWER =================
  Widget _buildDrawer(LoginController controller) {
    return Drawer(
      child: Obx(
        () => ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTokens.primary900, AppTokens.primary600],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Text(
                      controller.userName.value.isNotEmpty
                          ? controller.userName.value[0].toUpperCase()
                          : 'U',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTokens.primary900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.userName.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "@${controller.userDetail.value}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => Get.back(),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () => Get.offAllNamed('/login'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionItem {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  _ActionItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}
