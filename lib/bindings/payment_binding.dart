import 'package:deliveryapp/controllers/payment_controller.dart';
import 'package:deliveryapp/util/model/order.dart';
import 'package:deliveryapp/util/services/order_service.dart';
import 'package:get/get.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    final order = Get.arguments as Order;
    Get.lazyPut(() => PaymentController(Get.find<OrderService>(), order));
  }
}
