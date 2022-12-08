import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class DetailSeminarController extends GetxController {
  String scanQr = '';

  void onInit() {
    super.onInit();
  }

  void onReady() {
    super.onReady();
  }

  void onClose() {
    super.onClose();
  }

  Future<void> scanQcode() async {
    try {
      scanQr = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      Get.snackbar("Result", "QR Code" + scanQr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } on PlatformException {}
  }
}
