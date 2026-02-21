import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerController extends GetxController {
  final Rx<String?> scannedId = Rx<String?>(null);
  bool isDetected = false;

  void onDetect(Barcode barcode) {
    if (isDetected) return;

    final id = barcode.rawValue;
    if (id == null) return;

    try {
      isDetected = true;
      scannedId.value = id;

      if (Get.isDialogOpen ?? false) {
        Get.back(result: id);
      }
    } catch (e) {
      Get.snackbar("Error", "Invalid QR Code");
      isDetected = false;
      throw Exception("Invalid QR Code : $e");
    }
  }

  void reset() {
    isDetected = false;
    scannedId.value = null;
  }
}
