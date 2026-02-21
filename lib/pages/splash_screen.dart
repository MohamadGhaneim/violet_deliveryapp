import 'dart:async';

import 'package:deliveryapp/config/app_routes.dart';
import 'package:deliveryapp/repository/sheard_preferances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () async => Get.offAllNamed(
        await PrefHelper.isloggedin() ? AppRoutes.rootPage : AppRoutes.login,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox.expand(
          child: Image.asset('assets/images/splash.jpg', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
