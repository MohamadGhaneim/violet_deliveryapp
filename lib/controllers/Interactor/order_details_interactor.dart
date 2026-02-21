import 'package:deliveryapp/util/services/order_service.dart';
import 'package:deliveryapp/util/types.dart';

class OrderDetailsInteractor {
  final OrderService orderService;
  OrderDetailsInteractor(this.orderService);

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
}
