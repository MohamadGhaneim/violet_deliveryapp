import 'package:deliveryapp/components/notification_card.dart';
import 'package:deliveryapp/controllers/notifications_controller.dart';
import 'package:deliveryapp/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Notifications'),
        backgroundColor: AppColors.deepBlue,
      ),
      body: Obx(() {
        if (controller.isActionLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!controller.isFetching.value && controller.notification.isEmpty) {
          return const Center(child: Text('No notifications yet'));
        }

        return RefreshIndicator(
          onRefresh: controller.refreshNotifications,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller.scrollController,
            itemCount:
                controller.notification.length +
                ((controller.isFetching.value && controller.hasMore.value)
                    ? 1
                    : 0),
            itemBuilder: (context, index) {
              if (index < controller.notification.length) {
                return NotificationCard(
                  notification: controller.notification[index],
                  onTap: () {
                    controller.goToOrderDetails(controller.notification[index]);
                  },
                );
              }
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        );
      }),
    );
  }
}
