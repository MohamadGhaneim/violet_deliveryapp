import 'package:deliveryapp/controllers/auth_controller.dart';
import 'package:deliveryapp/controllers/login_controller.dart';
import 'package:deliveryapp/repository/local_storage.dart';
import 'package:deliveryapp/util/services/auth/auth_service.dart';
import 'package:deliveryapp/util/services/auth/google_signin_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    //Get.put(Dio());
    Get.put(AuthService(Get.find<Dio>()));
    Get.put(
      AuthController(
        Get.find<AuthService>(),
        Get.find<LocalStorage>(),
        Get.put(GoogleSigninService()),
      ),
    );
    Get.put(LoginController(Get.find<AuthController>()));
    //Get.put(SettingController(Get.find<AuthController>()));
  }
}
