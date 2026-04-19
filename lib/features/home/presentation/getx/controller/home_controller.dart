import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../../../../../core/network/token_storage.dart';
import '../../../../../core/widget/snak_bar_service.dart';
import '../../../data/repository/attendance_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _attendanceRepository = HomeRepository();
  final RxString userDisplayName = 'User'.obs;
  RxInt currentIndex = 0.obs;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  bool isScanned = false;

  Future<void> loadUserName() async {
    final savedName = await TokenStorage.getUserName();
    if (savedName != null && savedName.trim().isNotEmpty) {
      userDisplayName.value = savedName.trim();
    }
  }

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
    await _submitAttendance(qrCode: qrCode, fallbackAction: 'check_in');
  }

  Future<void> handleCheckOut(String qrCode) async {
    await _submitAttendance(qrCode: qrCode, fallbackAction: 'check_out');
  }

  Future<void> _submitAttendance({
    required String qrCode,
    required String fallbackAction,
  }) async {
    final result = await _attendanceRepository.submitAttendance(token: qrCode);

    result.fold(
      (failure) {
        SnackbarService.error(failure.message);
      },
      (response) {
        final body = response.data;
        final message = body is Map<String, dynamic>
            ? (body['message']?.toString().trim() ?? '')
            : '';
        final action = body is Map<String, dynamic>
            ? (body['action']?.toString().trim() ?? fallbackAction)
            : fallbackAction;
        final isSuccess = body is Map<String, dynamic>
            ? body['status'] == true
            : true;

        if (!isSuccess) {
          SnackbarService.error(
            message.isNotEmpty ? message : 'تعذر تسجيل الحضور',
          );
          return;
        }

        SnackbarService.success(
          message.isNotEmpty ? message : 'Attendance recorded successfully.',
        );
        print('Attendance action: $action');
      },
    );
  }

  void toggleFlash() {
    qrController?.toggleFlash();
  }

  @override
  void onInit() {
    super.onInit();
    loadUserName();
  }

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }
}