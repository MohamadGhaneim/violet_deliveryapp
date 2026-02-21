import 'package:deliveryapp/controllers/notifications_controller.dart';
import 'package:deliveryapp/controllers/order_controller.dart';
import 'package:deliveryapp/util/services/notification_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    // Make sure OrderController exists
    final orderController = Get.find<OrderController>();
    final dio = Get.find<Dio>();
    final notificationService = NotificationService(dio);

    Get.put(NotificationsController(notificationService, orderController));
  }
}
