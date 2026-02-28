import 'package:deliveryapp/components/app_scanner_dialog.dart';
import 'package:deliveryapp/config/app_routes.dart';
import 'package:deliveryapp/controllers/Interactor/order_details_interactor.dart';
import 'package:deliveryapp/styles/app_colors.dart';
import 'package:deliveryapp/util/model/order.dart';
import 'package:deliveryapp/util/types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsController extends GetxController {
  final Rx<Order> order;

  final OrderDetailsInteractor orderDetailsInteractor;
  OrderDetailsController(Order initialOrder, this.orderDetailsInteractor)
    : order = initialOrder.obs;
  var isLoading = false.obs;

  Future<void> openGoogleMap() async {
    final role = getOrderStatusCustomerOrShopOwner(order.value.status);
    final dynamic locationValue =
        role == 'customer'
            ? order.value.deliveryLocation.link
            : order.value.shop.location;
    final String locationStr = locationValue?.toString() ?? '';
    if (locationStr.isEmpty) {
      Get.snackbar("Oops!", 'Location is not available');
      return;
    }
    final Uri uri = Uri.parse(locationStr);
    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched) {
      Get.snackbar("Oops!", 'Could not open Google Maps');
      throw Exception('Could not open Google Maps');
    }
  }

  Future<void> openWhatsApp() async {
    final role = getOrderStatusCustomerOrShopOwner(order.value.status);
    final phone =
        role == 'customer'
            ? order.value.customer.phoneNumber
            : order.value.shop.phoneNumber;
    try {
      final Uri webUri = Uri.parse("https://wa.me/$phone");
      final launched = await launchUrl(
        webUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        Get.snackbar("Oops!", "Could not open WhatsApp");
      }
    } catch (e) {
      Get.snackbar("Oops!", 'Could not open WhatsApp');
      throw Exception('Could not open WhatsApp : $e');
    }
  }

  Future<void> updateWithLoading() async {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      await orderDetailsInteractor.updateOrderToTheNextStatus(
        orderNumber: order.value.orderNumber,
        orderStatus: order.value.status,
        paymentStatus: order.value.paymentStatus,
      );

      Get.back(); // close loading
      Get.snackbar(
        "Success",
        "Order status updated successfully",
        backgroundColor: AppColors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.back();

      Get.snackbar(
        "Error",
        "Failed to update order status",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      throw Exception("Failed to update order status : $e");
    }
  }

  Future<void> scanOnce() async {
    final scannedId = await Get.dialog<String>(
      ScannerDialog(),
      barrierDismissible: false,
    );

    if (scannedId == null) return;
    if (scannedId != order.value.orderNumber) {
      Get.rawSnackbar(
        message: "QR does not match this order",
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    await Get.dialog(
      Obx(
        () => AlertDialog(
          title: Text(
            "Confirm the status order to ${getNextOrderStatus(order.value.status, order.value.paymentStatus).value}?",
          ),
          content:
              isLoading.value
                  ? SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.deepBlue,
                      ),
                    ),
                  )
                  : Text("QR matches this order. Do you want to proceed?"),
          actions: [
            if (!isLoading.value)
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("No"),
              ),
            if (!isLoading.value)
              TextButton(
                onPressed: () {
                  Get.back();
                  updateWithLoading();
                },
                child: Text("Yes"),
              ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> payment() async {
    // route depands on the order type
    Get.toNamed(AppRoutes.payment, arguments: order.value);
  }
}
