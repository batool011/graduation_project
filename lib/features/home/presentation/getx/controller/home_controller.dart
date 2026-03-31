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

  // عند اكتشاف QR
  void onDetect(String value, String scanMode) {
    if (isScanned) return;
    isScanned = true;

    print("QR Value: $value"); // <--- هنا يطبع القيمة في terminal

    if (scanMode == 'in') {
      handleCheckIn(value);
    } else {
      handleCheckOut(value);
    }

    // بعد ثانيتين، يسمح بالمسح مرة أخرى
    Future.delayed(const Duration(seconds: 2), () {
      isScanned = false;
    });
  }

  // مثال: تسجيل الدخول
  Future<void> handleCheckIn(String qrCode) async {
    print("Check In: $qrCode");
    // هنا ترسلي للbackend
    // await sendAttendance(qrCode: qrCode, type: 'check_in');
    Get.snackbar('نجاح', 'تم تسجيل الدخول');
  }

  // مثال: تسجيل الخروج
  Future<void> handleCheckOut(String qrCode) async {
    print("Check Out: $qrCode");
    // هنا ترسلي للbackend
    // await sendAttendance(qrCode: qrCode, type: 'check_out');
    Get.snackbar('نجاح', 'تم تسجيل الخروج');
  }

  // للتحكم بالفلاش
  void toggleFlash() {
    qrController?.toggleFlash();
  }

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }
}