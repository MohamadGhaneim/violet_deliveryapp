import 'package:deliveryapp/styles/app_colors.dart';
import 'package:deliveryapp/util/model/order.dart';
import 'package:deliveryapp/util/services/order_service.dart';
import 'package:deliveryapp/util/types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final Rx<Order> order;
  final OrderService orderService;
  PaymentController(this.orderService, Order order) : order = order.obs;
  RxBool isload = false.obs;
  final RxBool isExchangePay = true.obs;
  final RxBool collectExchange = false.obs;
  final TextEditingController usdController = TextEditingController();
  final TextEditingController lbpController = TextEditingController();

  @override
  void onInit() {
    usdController.text = order.value.total.toStringAsFixed(2);
    super.onInit();
  }

  void togglePayment(int index) {
    isExchangePay.value = index == 0;
  }

  Future<void> checkOrderStatus() async {
    try {
      isload.value = true;
      final double lbp = double.tryParse(lbpController.text) ?? 0.0;
      final double usd = double.tryParse(usdController.text) ?? 0.0;
      await orderService.orderPayment(order.value.orderNumber, usd, lbp);
      await orderService.updateOrderToTheNextStatus(
        order.value.orderNumber,
        getNextOrderStatus(order.value.status, order.value.paymentStatus).value,
      );

      Get.snackbar(
        "Success",
        "Order payment successfully",
        backgroundColor: AppColors.green,
        colorText: Colors.white,
      );
      Get.close(2);
    } catch (e) {
      Get.snackbar(
        "Failed",
        "Order payment failed",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      throw Exception("PaymentController confirmPayment error: $e");
    } finally {
      isload.value = false;
    }
  }

  Future<void> confirmPayment() async {
    try {
      isload.value = true;
      final double lbp = double.tryParse(lbpController.text) ?? 0.0;
      final double usd = double.tryParse(usdController.text) ?? 0.0;
      await orderService.orderPayment(order.value.orderNumber, usd, lbp);

      Get.snackbar(
        "Success",
        "Order payment successfully",
        backgroundColor: AppColors.green,
        colorText: Colors.white,
      );
      Get.close(2);
    } catch (e) {
      Get.snackbar(
        "Failed",
        "Order payment failed",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      throw Exception("PaymentController confirmPayment error: $e");
    } finally {
      isload.value = false;
    }
  }

  @override
  void onClose() {
    usdController.dispose();
    lbpController.dispose();
    super.onClose();
  }
}
