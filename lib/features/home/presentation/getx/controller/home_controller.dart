import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  bool isScanned = false;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void onDetect(String value, String scanMode) {
    if (isScanned) return;
    isScanned = true;

    print("QR Value: $value");

    if (scanMode == 'in') {
      handleCheckIn(value);
    } else {
      handleCheckOut(value);
    }

    Future.delayed(const Duration(seconds: 2), () {
      isScanned = false;
    });
  }

  Future<void> handleCheckIn(String qrCode) async {
    print("Check In: $qrCode");
    // await sendAttendance(qrCode: qrCode, type: 'check_in');
    Get.snackbar('نجاح', 'تم تسجيل الدخول');
  }

  Future<void> handleCheckOut(String qrCode) async {
    print("Check Out: $qrCode");
    // await sendAttendance(qrCode: qrCode, type: 'check_out');
    Get.snackbar('نجاح', 'تم تسجيل الخروج');
  }

  void toggleFlash() {
    qrController?.toggleFlash();
  }

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }
}