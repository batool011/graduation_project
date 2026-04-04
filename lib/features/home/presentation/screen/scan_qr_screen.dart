import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../getx/controller/home_controller.dart';

class ScanQrScreen extends StatelessWidget {
  final String scanMode;
  ScanQrScreen({super.key, required this.scanMode});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity,70),
          child: CustomAppBar(text: AppString.scanQr.tr,)),
      body: Stack(
        children: [
          QRView(
            key: controller.qrKey,
            onQRViewCreated: (QRViewController qrViewController) {
              controller.qrController = qrViewController;
              qrViewController.scannedDataStream.listen((scanData) {
                controller.onDetect(scanData.code ?? '', scanMode);
              });
            },
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