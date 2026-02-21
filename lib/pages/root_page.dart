import 'package:deliveryapp/config/app_routes.dart';
import 'package:deliveryapp/controllers/root_controller.dart';
import 'package:deliveryapp/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class RootPage extends GetView<RootController> {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepBlue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.deepBlue,
        centerTitle: false,
        title: Text(
          controller.setWelcomeMessage(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Obx(
            () => Stack(
              children: [
                IconButton(
                  icon: Icon(
                    controller.hasNotification.value
                        ? IconlyBold.notification
                        : IconlyLight.notification,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoutes.notifications);
                  },
                ),
                if (controller.hasNotification.value)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: controller.pages,
        ),
      ),

      bottomNavigationBar: Obx(
        () => NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
              states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                  color: AppColors.amberYellow,
                  fontWeight: FontWeight.bold,
                );
              }
              return const TextStyle(color: Colors.white70);
            }),
          ),
          child: NavigationBar(
            height: 65,
            backgroundColor: AppColors.deepBlue,
            indicatorColor: AppColors.amberYellow.withValues(alpha: 0.15),
            selectedIndex: controller.index.value,
            onDestinationSelected: (value) {
              controller.changePage(value);
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                icon: Icon(IconlyLight.home, color: Colors.white70),
                selectedIcon: Icon(
                  IconlyBold.home,
                  color: AppColors.amberYellow,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(IconlyLight.time_circle, color: Colors.white70),
                selectedIcon: Icon(
                  IconlyBold.time_circle,
                  color: AppColors.amberYellow,
                ),
                label: 'Archive',
              ),
              NavigationDestination(
                icon: Icon(IconlyLight.setting, color: Colors.white70),
                selectedIcon: Icon(
                  IconlyBold.setting,
                  color: AppColors.amberYellow,
                ),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
