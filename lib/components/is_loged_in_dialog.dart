import 'package:deliveryapp/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotLoggedInDialog extends StatelessWidget {
  const NotLoggedInDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("Not Logged In", textAlign: TextAlign.center),
      content: const Text(
        "You need to sign in first",
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            Get.offAllNamed(AppRoutes.login);
          },
          child: const Text("Login"),
        ),
      ],
    );
  }
}
