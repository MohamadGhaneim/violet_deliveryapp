import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:iconly/iconly.dart';
import '../controllers/qr_scanner_id_controller.dart';

class ScannerDialog extends GetView<QrScannerController> {
  const ScannerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final scannerController = MobileScannerController();
    controller.reset();

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.8),
      body: Stack(
        children: [
          MobileScanner(
            controller: scannerController,
            onDetect: (barcode) {
              controller.onDetect(barcode.barcodes.first);
            },
          ),
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: const Icon(
                IconlyLight.close_square,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                scannerController.dispose();
                Get.back();
              },
            ),
          ),

          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
