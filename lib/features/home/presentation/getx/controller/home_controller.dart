import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  StreamSubscription<Barcode>? _scanSubscription;
  bool isScanned = false;

  Future<void> loadUserName() async {
    final savedName = await TokenStorage.getUserName();
    if (savedName != null && savedName.trim().isNotEmpty) {
      userDisplayName.value = savedName.trim();
    }
  }
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception("Location permission denied.");
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permission permanently denied.");
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void onDetect(String value, String scanMode) {
    if (value.trim().isEmpty) return;
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
      qrController?.resumeCamera();
    });
  }

  void onQrViewCreated(QRViewController controller, String scanMode) {
    qrController = controller;
    _scanSubscription?.cancel();
    _scanSubscription = controller.scannedDataStream.listen((scanData) {
      qrController?.pauseCamera();
      onDetect(scanData.code ?? '', scanMode);
    });
  }

  void handleQrPermission(bool isGranted) {
    if (!isGranted) {
      SnackbarService.error('يرجى السماح بالوصول إلى الكاميرا');
    }
  }

  Future<void> pauseQrCamera() async {
    await qrController?.pauseCamera();
  }

  Future<void> resumeQrCamera() async {
    await qrController?.resumeCamera();
  }

  Future<void> disposeQrResources() async {
    await _scanSubscription?.cancel();
    _scanSubscription = null;
    qrController?.dispose();
    qrController = null;
    isScanned = false;
  }

  Future<void> handleCheckIn(String qrCode) async {
    try {
      Position position = await getCurrentLocation();

      await _submitAttendance(
        qrCode: qrCode,
        fallbackAction: 'check_in',
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      SnackbarService.error(e.toString());
    }
  }

  Future<void> handleCheckOut(String qrCode) async {
    try {
      Position position = await getCurrentLocation();

      await _submitAttendance(
        qrCode: qrCode,
        fallbackAction: 'check_out',
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      SnackbarService.error(e.toString());
    }
  }

  Future<void> _submitAttendance({
    required String qrCode,
    required String fallbackAction,
    required double latitude,
    required double longitude,
  }) async {
    final result = await _attendanceRepository.submitAttendance(
      token: qrCode,
      latitude: latitude,
      longitude: longitude,
    );

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
          message.isNotEmpty
              ? message
              : 'Attendance recorded successfully.',
        );

        print('Attendance action: $action');
        print('Latitude: $latitude');
        print('Longitude: $longitude');
      },
    );
  }

  void toggleFlash() {
    qrController?.toggleFlash();
  }

  @override
  void onInit()async {
    super.onInit();
    loadUserName();
    Position position = await getCurrentLocation();
    print("======================position.longitude");

    print(position.longitude);
    print(position.latitude);
  }

  @override
  void onClose() {
    _scanSubscription?.cancel();
    qrController?.dispose();
    super.onClose();
  }
}