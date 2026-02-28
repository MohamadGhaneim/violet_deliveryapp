import 'package:deliveryapp/config/app_routes.dart';
import 'package:deliveryapp/controllers/order_controller.dart';
import 'package:deliveryapp/styles/app_colors.dart';
import 'package:deliveryapp/util/model/app_notification.dart';
import 'package:deliveryapp/util/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final NotificationService service;
  final OrderController orderController;
  NotificationsController(this.service, this.orderController);

  var notification = <AppNotification>[].obs;
  var isFetching = false.obs; // pagination
  var isActionLoading = false.obs; // goToOrderDetails

  RxInt page = 1.obs;
  final int limit = 10;
  var hasMore = true.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        fetchNotifications();
      }
    });
  }

  Future<void> refreshNotifications() async {
    notification.clear();
    page.value = 1;
    hasMore.value = true;
    await fetchNotifications();
  }

  Future<void> goToOrderDetails(AppNotification selectedNotification) async {
    try {
      isActionLoading.value = true;
      if (!selectedNotification.isRead) {
        await service.notificationIsRead(selectedNotification);
      }
      if (selectedNotification.orderId == null || selectedNotification.isRead) {
        return;
      }
      final order = orderController.orders.firstWhereOrNull(
        (o) => o.id == selectedNotification.orderId,
      );

      if (order == null) {
        Get.snackbar(
          'Opss',
          'no Order found, refreshing orders...',
          backgroundColor: AppColors.amberYellow,
        );
        return;
      }
      Get.toNamed(AppRoutes.orderDetails, arguments: order);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isActionLoading.value = false;
    }
  }

  Future<void> fetchNotifications() async {
    if (isFetching.value || !hasMore.value) return;
    isFetching.value = true;
    try {
      final newNotifications = await service.getUserNotifications(page.value);
      if (newNotifications.isEmpty) {
        hasMore.value = false;
      } else {
        notification.addAll(newNotifications);
        page.value++;
      }
    } finally {
      isFetching.value = false;
    }
  }
}
