import 'package:deliveryapp/components/app_elevated_button.dart';
import 'package:deliveryapp/components/app_text_field.dart';
import 'package:deliveryapp/config/app_routes.dart';
import 'package:deliveryapp/controllers/login_controller.dart';
import 'package:deliveryapp/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.darkGray,
        body: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
            ),

            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/images/logo_login.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Sign In",
                      style: TextStyle(
                        color: AppColors.deepBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'To sign in to an account in the application,\n'
                      'Enter your email and password',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: AppColors.darkGray),
                    ),
                    SizedBox(height: 20),

                    AppTextField(
                      icon: Icon(IconlyBold.message),
                      hint: 'E-mail',
                      controller: controller.emailControl,
                    ),

                    SizedBox(height: 20),
                    AppTextField(
                      icon: Icon(IconlyBold.lock),
                      hint: 'Password',
                      controller: controller.passwordControl,
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () => {Get.toNamed(AppRoutes.forgotPassword)},
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: AppColors.deepBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () => AppElevatedButton(
                        text: 'Continue',
                        bgColor: AppColors.deepBlue,
                        onPressed: () {
                          controller.login();
                        },
                        isWait: controller.isLoading.value,
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.darkGray,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Or',
                            style: TextStyle(
                              color: AppColors.darkGray,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.darkGray,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    AppElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.rootPage);
                        //controller.googleSignOut();
                      },
                      text: 'Guest',
                      bgColor: const Color.fromARGB(255, 141, 204, 255),
                      isWait: false,
                    ),
                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        controller.googleSignin();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        backgroundColor: AppColors.lightGray,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              width: screenWidth * 0.08,
                            ),
                            Text(
                              '  Sign in with Google',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
