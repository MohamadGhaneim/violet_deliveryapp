import 'package:deliveryapp/controllers/order_controller.dart';
import 'package:deliveryapp/controllers/qr_scanner_id_controller.dart';
import 'package:deliveryapp/util/services/order_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class OrdeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(QrScannerController());
    Get.put(OrderService(Get.find<Dio>()));
    Get.put(OrderController(Get.find<OrderService>()));
  }
}
