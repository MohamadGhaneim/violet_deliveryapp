// setting_binding.dart
import 'package:deliveryapp/repository/local_storage.dart';
import 'package:deliveryapp/util/services/auth/auth_service.dart';
import 'package:deliveryapp/util/services/auth/google_signin_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../controllers/setting_controller.dart';
import '../controllers/auth_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService(Get.find<Dio>()));
    Get.put(
      AuthController(
        Get.find<AuthService>(),
        Get.find<LocalStorage>(),
        Get.find<GoogleSigninService>(),
      ),
    );
    Get.lazyPut(() => SettingController(Get.find<AuthController>()));
  }
}
