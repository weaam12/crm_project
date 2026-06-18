import 'package:crm_project/core/const/app_tokens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../busnisses_Logic_layer/controller/auth_controller.dart';

class PlatformDrawer extends StatelessWidget {
  PlatformDrawer({super.key});

  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          /// Header
          Obx(
            () => UserAccountsDrawerHeader(
               decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTokens.primary900, AppTokens.primary600],
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.admin_panel_settings,
                  color: Color(0xff0F172A),
                  size: 35,
                ),
              ),
              accountName: Text(
                controller.userName.value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(controller.userDetail.value),
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [

                _drawerItem(
                  icon: Icons.dashboard,
                  title: "Dashboard",
                  route: '/platform-dashboard',
                ),

                const Divider(),

                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Management",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                _drawerItem(
                  icon: Icons.domain,
                  title: "Tenants",
                  route: '/platform-tenants',
                ),

                _drawerItem(
                  icon: Icons.payments,
                  title: "Subscriptions",
                  route: '/platform-subscriptions',
                ),

                const Divider(),

                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Access Control",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                _drawerItem(
                  icon: Icons.people,
                  title: "Profiles",
                  route: '/platform-profiles',
                ),

                _drawerItem(
                  icon: Icons.lock,
                  title: "Permissions",
                  route: '/platform-permissions',
                ),

                const Divider(),

                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "System",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                _drawerItem(
                  icon: Icons.history,
                  title: "Audit Logs",
                  route: '/platform-audit-logs',
                ),

                _drawerItem(
                  icon: Icons.settings,
                  title: "Settings",
                  route: '/platform-settings',
                ),
              ],
            ),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Get.offAllNamed('/login');
            },
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required String route,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Get.back();
        Get.toNamed(route);
      },
    );
  }
}