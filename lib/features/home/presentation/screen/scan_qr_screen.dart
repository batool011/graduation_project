import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../getx/controller/home_controller.dart';

class ScanQrScreen extends StatefulWidget {
  final String scanMode;
  const ScanQrScreen({super.key, required this.scanMode});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  late final HomeController controller;

  @override
  void initState() {
    super.initState();
    controller =
        Get.isRegistered<HomeController>() ? Get.find<HomeController>() : Get.put(HomeController());
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseQrCamera();
    }
    controller.resumeQrCamera();
  }

  @override
  void dispose() {
    controller.disposeQrResources();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.scanQr.tr),
      ),
      body: Stack(
        children: [
          QRView(
            key: controller.qrKey,
            onQRViewCreated: (qrViewController) =>
                controller.onQrViewCreated(qrViewController, widget.scanMode),
            onPermissionSet: (_, isGranted) => controller.handleQrPermission(isGranted),
            overlay: QrScannerOverlayShape(
              borderColor: AppColor.primaryColor,
              borderRadius: 12,
              borderLength: 30,
              borderWidth: 6,
              cutOutSize: 260,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.toggleFlash,
        child: const Icon(Icons.flash_on),
      ),
    );
  }
}