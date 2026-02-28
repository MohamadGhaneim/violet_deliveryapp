import 'package:deliveryapp/config/app_routes.dart';
import 'package:deliveryapp/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();

  final AuthController authController;

  LoginController(this.authController);

  Future<void> googleSignin() async {
    try {
      final fullName = await authController.signin();

      if (fullName.isNotEmpty) {
        Get.offAllNamed(AppRoutes.rootPage, arguments: {"full_name": fullName});
        Get.snackbar(
          backgroundColor: Colors.green,
          "Login Successfuly",
          "welcome , $fullName",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Google Signin Failed",
        "try agin",
        snackPosition: SnackPosition.BOTTOM,
      );
      throw Exception('LoginController googleSignin error : $e');
    }
  }

  Future<void> login() async {
    if (emailControl.text.trim().isEmpty ||
        passwordControl.text.trim().isEmpty) {
      Get.snackbar("Warning", "Please fill in all fields");
      return;
    }

    try {
      isLoading.value = true;

      String fullName = await authController.login(
        emailControl.text,
        passwordControl.text,
      );

      if (fullName.isNotEmpty) {
        Get.offAllNamed(AppRoutes.rootPage, arguments: {"full_name": fullName});
        Get.snackbar(
          backgroundColor: Colors.green,
          "Login Successfuly",
          "welcome , $fullName",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Login Failed",
        "Invalid Email Or Password",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      throw Exception('LoginController Login error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
