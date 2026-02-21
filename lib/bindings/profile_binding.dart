import 'package:deliveryapp/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:deliveryapp/controllers/Interactor/profile_interactor.dart';
import 'package:deliveryapp/util/services/auth/authenticated_dio.dart';
import 'package:deliveryapp/util/services/user_service.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserService>(
      () => UserService(Get.find<AuthenticatedDio>().dio),
    );
    Get.lazyPut<ProfileInteractor>(
      () => ProfileInteractor(Get.find<UserService>()),
    );
    Get.put(ProfileController(Get.find<ProfileInteractor>()));
  }
}
