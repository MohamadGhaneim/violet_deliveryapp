import 'package:deliveryapp/controllers/root_controller.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>?;
    final fullName = args?["full_name"] ?? "Guest";
    Get.put(RootController(fullName));
  }
}
