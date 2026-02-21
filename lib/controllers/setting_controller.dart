import 'package:deliveryapp/components/confirm_box.dart';
import 'package:deliveryapp/config/app_routes.dart';
import 'package:deliveryapp/controllers/auth_controller.dart';
import 'package:deliveryapp/repository/sheard_preferances.dart';
import 'package:deliveryapp/util/model/delivery.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final AuthController authController;
  SettingController(this.authController);

  var delivery = Rxn<Delivery>();

  @override
  onInit() {
    super.onInit();
    setprofile();
  }

  void editProfile() {
    Get.toNamed(AppRoutes.editProfile);
  }

  Future<void> setprofile() async {
    delivery.value = await PrefHelper.getDelivery();
  }

  void logout() async {
    // await Prefeshelper.logout();
    // isLoggedIn.value = false;
    bool confirm = await ConfirmBox.show(
      title: "Logout",
      content: "Are you sure you want to logout?",
    );

    if (confirm) {
      authController.logout();
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
