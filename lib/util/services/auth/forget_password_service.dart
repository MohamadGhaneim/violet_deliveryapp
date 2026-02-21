import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordService {
  final Dio dio;
  ForgetPasswordService(this.dio);
  Future<void> sendResetPasswordEmail(String email) async {
    try {
      Get.snackbar(
        backgroundColor: Colors.green,
        "Email sender success",
        "Please Check your email",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      throw Exception("Forget password Error : $e");
    }
  }
}
