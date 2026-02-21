import 'package:deliveryapp/util/model/delivery.dart';
import 'package:deliveryapp/util/services/path.dart';
import 'package:dio/dio.dart';

class UserService {
  final Dio dio;
  UserService(this.dio);
  Future<Delivery> getDelivery() async {
    try {
      final response = await dio.get(MyPath.getDelivery);
      if (response.statusCode! >= 300) {
        throw Exception("Server Error: ${response.statusCode}");
      }
      final Delivery delivery = Delivery.fromJson(response.data);
      //print(delivery.email);
      return delivery;
    } catch (e) {
      throw Exception("Failed to get delivery: $e");
    }
  }

  Future<void> updateDelivery(Delivery delivery) async {
    try {
      final response = await dio.put(
        MyPath.updateDriver,
        data: delivery.toJson(),
      );
      if (response.statusCode! >= 300) {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to put delivery: $e");
    }
  }
}
