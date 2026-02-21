import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmBox {
  /// Show a confirmation dialog
  static Future<bool> show({
    required String title,
    required String content,
    String yesText = "Yes",
    String noText = "No",
  }) async {
    bool result = false;

    await Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              result = false;
              Get.back();
            },
            child: Text(noText),
          ),
          ElevatedButton(
            onPressed: () {
              result = true;
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(yesText, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    return result;
  }
}
