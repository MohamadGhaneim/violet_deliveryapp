import 'package:deliveryapp/util/services/order_service.dart';

class PaymentInteractor {
  final OrderService orderService;
  PaymentInteractor(this.orderService);
  Future<void> payment({
    required String orderNumber,
    required double usdAmount,
    required double lbpAmount,
  }) async {
    try {
      await orderService.orderPayment(orderNumber, usdAmount, lbpAmount);
    } catch (e) {
      throw Exception("Failed to update payment status: $e");
    }
  }
}
