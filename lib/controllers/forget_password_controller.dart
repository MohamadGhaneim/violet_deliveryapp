import 'package:deliveryapp/util/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final emailForgotpassword = TextEditingController();
  var isLoading = false.obs;

  Future<void> sendResetPasswordEmail() async {
    if (emailForgotpassword.text.isEmpty) {
      Get.snackbar("Error", "Please enter your email");
      return;
    }
    try {
      isLoading.value = true;
      final authService = Get.find<AuthService>();
      await authService.forgetPassword(emailForgotpassword.text.trim());
      Get.snackbar(
        "Success",
        "Reset password email sent",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send reset password email",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      throw Exception(
        'ForgetPasswordController sendResetPasswordEmail error: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
