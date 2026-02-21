import 'package:deliveryapp/controllers/forget_password_controller.dart';
import 'package:deliveryapp/repository/local_storage.dart';
import 'package:deliveryapp/util/services/auth/authenticated_dio.dart';
import 'package:deliveryapp/util/services/auth/google_signin_service.dart';
import 'package:deliveryapp/util/services/order_service.dart';
import 'package:deliveryapp/util/services/user_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Local storage
    Get.put(LocalStorage(), permanent: true);

    // Base Dio
    final dio = Dio();
    Get.put(dio, permanent: true);

    // Authenticated Dio
    Get.put(GoogleSigninService());
    Get.put(
      AuthenticatedDio(Get.find<Dio>(), Get.find<LocalStorage>()),
      permanent: true,
    );
    Get.put(ForgetPasswordController());
    // Services
    Get.lazyPut<OrderService>(
      () => OrderService(Get.find<AuthenticatedDio>().dio),
    );
    Get.lazyPut<UserService>(
      () => UserService(Get.find<AuthenticatedDio>().dio),
    );
  }
}
