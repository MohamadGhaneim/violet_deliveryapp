import 'package:deliveryapp/util/model/order.dart';
import 'package:deliveryapp/util/services/path.dart';
import 'package:dio/dio.dart';

class OrderService {
  final Dio dio;
  OrderService(this.dio);

  Future<List<Order>> getAllOrdersDriver() async {
    try {
      final response = await dio.get(MyPath.ordersByDriver);
      if (response.statusCode! >= 300) {
        throw Exception("Server Error: ${response.statusCode}");
      }
      final List<Order> orders =
          (response.data as List).map((json) => Order.fromJson(json)).toList();

      return orders;
    } catch (e) {
      throw Exception("Failed to fetch orders: $e");
    }
  }

  // get order  archive by MyPath.allOrdersArchive
  Future<List<Order>> getOrdersArchive() async {
    try {
      final response = await dio.get(MyPath.allOrdersArchive);
      if (response.statusCode! >= 300) {
        throw Exception("Server Error: ${response.statusCode}");
      }
      final List<Order> orders =
          (response.data as List).map((json) => Order.fromJson(json)).toList();

      return orders;
    } catch (e) {
      throw Exception("Failed to fetch orders: $e");
    }
  }

  Future<void> orderPayment(
    String orderNumber,
    double dollarBalance,
    double lLBBalance,
  ) async {
    try {
      final Map<String, dynamic> data = {
        "order_number": orderNumber, // string
        "currency_id": 1, // int
        "amount_usd": dollarBalance, //double
        "amount": lLBBalance, // double
      };

      final response = await dio.post(MyPath.payment, data: data);

      if (response.statusCode == null || response.statusCode! >= 300) {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to update order task: $e");
    }
  }

  Future<void> updateOrderToTheNextStatus(
    String orderNumber,
    String orderStatus,
  ) async {
    try {
      final response = await dio.put(
        MyPath.updateOrderStatus,
        data: {"order_number": orderNumber, "status": orderStatus},
      );
      if (response.statusCode! >= 300) {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to update next status order: $e");
    }
  }
}
