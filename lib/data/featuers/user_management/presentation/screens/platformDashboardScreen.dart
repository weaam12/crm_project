
import 'package:crm_project/core/theme/app_tokens.dart';
import 'package:crm_project/data/featuers/user_management/presentation/controllers/auth_controller.dart';
import 'package:crm_project/data/featuers/user_management/presentation/widgets/platformDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlatformDashboardScreen extends StatelessWidget {
  PlatformDashboardScreen({super.key});

  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PlatformDrawer(),
      backgroundColor: const Color(0xffF4F7FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Obx(() => Text(controller.workspaceName.value)),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          int crossAxisCount;
          if (width < 600) {
            crossAxisCount = 2;
          } else if (width < 900) {
            crossAxisCount = 3;
          } else {
            crossAxisCount = 4;
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeaderWidget(controller: controller),

                SizedBox(height: width * 0.05),

                const Text(
                  "Statistics",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: width * 0.03),

                _StatsSection(controller: controller),

                SizedBox(height: width * 0.06),

                const Text(
                  "Quick Actions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: width * 0.03),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return _DashboardCard(item: _items[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  final LoginController controller;

  const _HeaderWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [AppTokens.primary900, AppTokens.primary600],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Welcome 👋", style: TextStyle(color: Colors.white70)),

            const SizedBox(height: 10),

            Text(
              controller.userName.value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              controller.userDetail.value,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      );
    });
  }
}

class _StatsSection extends StatelessWidget {
  final LoginController controller;

  const _StatsSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Wrap(
        spacing: 15,
        runSpacing: 15,
        children: [
          _StatCard(
            title: "Permissions",
            value: controller.permissionsCount.value.toString(),
            icon: Icons.security,
            color: Colors.blue,
          ),

          _StatCard(
            title: "Role",
            value: controller.profileName.value,
            icon: Icons.badge,
            color: Colors.green,
          ),
        ],
      );
    });
  }
}

class _DashboardCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _DashboardCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(item["route"]),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(.12), blurRadius: 10),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: item["color"].withOpacity(.15),
              child: Icon(item["icon"], color: item["color"]),
            ),
            const SizedBox(height: 10),
            Text(
              item["title"],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> _items = [
  {
    "title": "Tenants",
    "icon": Icons.domain,
    "color": Colors.teal,
    "route": "/platform-tenants",
  },
  {
    "title": "Subscriptions",
    "icon": Icons.payments,
    "color": Colors.orange,
    "route": "/platform-subscriptions",
  },
  {
    "title": "Profiles",
    "icon": Icons.people,
    "color": Colors.purple,
    "route": "/platform-profiles",
  },
  {
    "title": "Permissions",
    "icon": Icons.lock,
    "color": Colors.blue,
    "route": "/platform-permissions",
  },
  {
    "title": "Audit Logs",
    "icon": Icons.history,
    "color": Colors.red,
    "route": "/platform-audit-logs",
  },
  {
    "title": "Settings",
    "icon": Icons.settings,
    "color": Colors.indigo,
    "route": "/platform-settings",
  },
];

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.12), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(.15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(value),
        ],
      ),
    );
  }
}
