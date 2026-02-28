import 'package:deliveryapp/components/app_scanner_dialog.dart';
import 'package:deliveryapp/components/is_loged_in_dialog.dart';
import 'package:deliveryapp/config/app_routes.dart';
import 'package:deliveryapp/repository/sheard_preferances.dart';
import 'package:deliveryapp/styles/app_colors.dart';
import 'package:deliveryapp/util/model/order.dart';
import 'package:deliveryapp/util/services/order_service.dart';
import 'package:deliveryapp/util/types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final OrderService orderService;
  OrderController(this.orderService);
  var orders = <Order>[].obs;
  var isLoading = false.obs;
  var selectedStatus = OrderStatus.all.obs;

  var archiveOrders = <Order>[].obs;
  //var filterdarchiveOrders = <Order>[].obs;
  var selectedDeliveryStatus = DeliveryCase.shopOwner.obs;

  var selectedDate = Rxn<DateTime>();
  final Set<OrderStatus> archiveCustomerStatus = {
    OrderStatus.delivered,
    OrderStatus.delayed,
    OrderStatus.returned,
    OrderStatus.deliveredWithExchange,
  };
  final Set<OrderStatus> archiveShopStatus = {
    OrderStatus.pickedUp,
    OrderStatus.paidToShop,
    OrderStatus.exchangeDelivered,
  };

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
      context: context,
    );

    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  List<Order> filterarchivedOrdersByDate(List<Order> orders) {
    if (selectedDate.value == null) return archiveOrders;

    return archiveOrders.where((order) {
      final orderDate = order.estimatedDeliveryTime;
      return orderDate.year == selectedDate.value!.year &&
          orderDate.month == selectedDate.value!.month &&
          orderDate.day == selectedDate.value!.day;
    }).toList();
  }

  List<Order> filterArchiveOrdersByStatus(List<Order> orders) {
    if (selectedDeliveryStatus.value == DeliveryCase.shopOwner) {
      return orders.where((o) => archiveShopStatus.contains(o.status)).toList();
    } else if (selectedDeliveryStatus.value == DeliveryCase.customer) {
      return orders
          .where((o) => archiveCustomerStatus.contains(o.status))
          .toList();
    }
    return orders.toList();
  }

  List<Order> get filterArchiveOrders {
    final filteredByDate = filterarchivedOrdersByDate(archiveOrders);
    return filterArchiveOrdersByStatus(filteredByDate);
  }

  // set order archive
  Future<void> setOrdersArchive() async {
    try {
      final loggedin = await PrefHelper.isloggedin();
      if (!loggedin) {
        return;
      }
      isLoading.value = true;
      archiveOrders.value = await orderService.getOrdersArchive();
    } catch (e) {
      throw Exception('Faild to controll all orders : $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setAllOrdersDriver() async {
    try {
      final loggedin = await PrefHelper.isloggedin();
      if (!loggedin) {
        return;
      }
      isLoading.value = true;
      orders.value = await orderService.getAllOrdersDriver();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to get all Orders",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      throw Exception('Faild to controll all orders : $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshOrders() async {
    await setAllOrdersDriver();
  }

  List<Order> get filteredOrders {
    if (selectedStatus.value == OrderStatus.all) {
      return orders.toList();
    }
    return orders.where((o) => o.status == selectedStatus.value).toList();
  }

  void goToOrderDetails(Order order) {
    Get.toNamed(AppRoutes.orderDetails, arguments: order);
  }

  // methode get order from orders by order number
  Order getOrderByNumber(String orderNumber) {
    try {
      final order = orders.firstWhereOrNull(
        (o) =>
            o.orderNumber == orderNumber &&
            getOrderAction(o.status) == OrderActionType.scan,
      );
      if (order == null) {
        Get.rawSnackbar(
          message: "Order not found or not in the correct status for scanning",
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
        );
        throw Exception("Order not found");
      }
      return order;
    } catch (e) {
      throw Exception("Order not found");
    }
  }

  Future<void> scanOnce() async {
    final loggedin = await PrefHelper.isloggedin();

    if (!loggedin) {
      Get.dialog(const NotLoggedInDialog());
      return;
    }

    final scannedId = await Get.dialog<String>(
      ScannerDialog(),
      barrierDismissible: false,
    );
    if (scannedId == null) return;
    final order = getOrderByNumber(scannedId);

    await Get.dialog(
      Obx(
        () => AlertDialog(
          title: Text(
            "Confirm the status order to ${getNextOrderStatus(order.status, order.paymentStatus).value}?",
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
                  _updateWithLoading(order);
                },
                child: Text("Yes"),
              ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _updateWithLoading(Order order) async {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      await updateOrderToTheNextStatus(
        orderNumber: order.orderNumber,
        orderStatus: order.status,
        paymentStatus: order.paymentStatus,
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

  Future<void> updateOrderToTheNextStatus({
    required String orderNumber,
    required OrderStatus orderStatus,
    required PaymentStatus paymentStatus,
  }) async {
    if (orderStatus.value.isEmpty || paymentStatus.value.isEmpty) {
      throw Exception("Order status or payment status is empty");
    }
    final nextStatus = getNextOrderStatus(orderStatus, paymentStatus);

    try {
      await orderService.updateOrderToTheNextStatus(
        orderNumber,
        OrderStatusLabel(nextStatus).value,
      );
    } catch (e) {
      throw Exception("Failed to update order status: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    setAllOrdersDriver();
    setOrdersArchive();
  }

  void changeStatus(OrderStatus status) {
    selectedStatus.value = status;
  }
}
