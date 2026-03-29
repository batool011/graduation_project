import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HomeController extends GetxController{
  RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  final MobileScannerController cameraController = MobileScannerController();
  bool isScanned = false;

  void onDetect(BarcodeCapture capture) {
  if (isScanned) return;

  final List<Barcode> barcodes = capture.barcodes;
  if (barcodes.isNotEmpty) {
  isScanned = true;
  final value = barcodes.first.rawValue ?? '';
  handleQrResult(value);
  }
  }

  void handleQrResult(String value) {
  if (value.contains('checkin')) {
  showMessage('تم تسجيل الحضور بنجاح');
  } else if (value.contains('checkout')) {
  showMessage('تم تسجيل الانصراف بنجاح');
  } else {
  showMessage('رمز غير صالح');
  }
  }

  void showMessage(String msg) {
  Get.snackbar(
  "نتيجة المسح",
  msg,
  snackPosition: SnackPosition.BOTTOM,
  duration: const Duration(seconds: 2),
  );

  Future.delayed(const Duration(seconds: 2), () {
  Get.back();
  });
  }

  void toggleFlash() {
  cameraController.toggleTorch();
  }


}