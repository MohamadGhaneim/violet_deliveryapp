import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerController extends GetxController {
  var scannedData = ''.obs;

  void handleBarcode(BarcodeCapture barcodes) {
    if (barcodes.barcodes.isNotEmpty) {
      final code = barcodes.barcodes.first.rawValue;
      if (code != null && code.isNotEmpty) {
        scannedData.value = code;
        Get.back();
      }
    }
  }
}
