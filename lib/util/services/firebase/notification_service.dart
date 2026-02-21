import 'dart:ui';

import 'package:deliveryapp/config/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static Future<void> init() async {
    // Permission
    await _messaging.requestPermission();

    // App opened from terminated state
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      _handleMessage(message);
    }

    // App opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessage(message);
    });

    // Foreground message
    FirebaseMessaging.onMessage.listen((message) {
      // Snackbar
      Get.snackbar(
        backgroundColor: const Color.fromARGB(255, 238, 198, 86),
        message.notification?.title ?? 'Notification',
        message.notification?.body ?? '',
      );
    });
  }

  static void _handleMessage(RemoteMessage message) {
    if (message.data['route'] == 'home') {
      Get.toNamed(AppRoutes.home);
    }
  }

  static Future<String> getFcmToken() async {
    String? token = await _messaging.getToken();
    return token.toString();
  }

  static void refreshToken(Function(String newToken) onRefresh) {
    _messaging.onTokenRefresh.listen(onRefresh);
  }
}
