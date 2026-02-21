import 'package:deliveryapp/components/app_elevated_button.dart';
import 'package:deliveryapp/components/app_text_field.dart';
import 'package:deliveryapp/controllers/forget_password_controller.dart';
import 'package:deliveryapp/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends GetView<ForgetPasswordController> {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Forgot Password'),
        backgroundColor: AppColors.deepBlue,
      ),
      backgroundColor: AppColors.lightGray,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 20,
                shadowColor: AppColors.deepBlue,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),

                  child: Column(
                    children: [
                      Text("Forgot your Password ?"),
                      SizedBox(height: 24),
                      AppTextField(
                        hint: "Email",
                        icon: const Icon(Icons.email),
                        controller: controller.emailForgotpassword,
                      ),
                      SizedBox(height: 24),
                      Obx(() {
                        return AppElevatedButton(
                          onPressed: controller.sendResetPasswordEmail,
                          text: "Send Reset Email",
                          isWait: controller.isLoading.value,
                          bgColor: AppColors.deepBlue,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
