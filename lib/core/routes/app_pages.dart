import 'package:crm_project/core/routes/app_routes.dart';
import 'package:crm_project/data/featuers/user_management/presentation/controllers/auth_controller.dart';
import 'package:crm_project/data/featuers/user_management/presentation/screens/login_screen.dart';
import 'package:crm_project/data/featuers/user_management/presentation/screens/platformDashboardScreen.dart';
import 'package:crm_project/data/featuers/user_management/presentation/screens/tenantDashboardScreen.dart';
import 'package:get/get.dart';


class AppPages {
 
  static const String initial = AppRoutes.login;

  static final List<GetPage> pages = [
    
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),

  
    GetPage(
      name: AppRoutes.platformDashboard,
      page: () =>  PlatformDashboardScreen(),
      transition: Transition.fadeIn,
    ),

   
    GetPage(
      name: AppRoutes.tenantDashboard,
      page: () => const TenantDashboardScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}