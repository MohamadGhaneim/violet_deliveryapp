import 'package:deliveryapp/controllers/Interactor/order_details_interactor.dart';
import 'package:deliveryapp/controllers/order_details_controller.dart';
import 'package:deliveryapp/util/model/order.dart';
import 'package:deliveryapp/util/services/order_service.dart';
import 'package:get/get.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final order = Get.arguments as Order;
    //final qrController = Get.put(QrScannerController());

    Get.put(
      OrderDetailsController(
        order,
        Get.put(OrderDetailsInteractor(Get.find<OrderService>())),
        // qrController,
      ),
    );
  }
}
