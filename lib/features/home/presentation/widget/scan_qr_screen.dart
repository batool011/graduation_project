import 'package:career/core/constant/class/app_color.dart';
import 'package:career/features/home/presentation/getx/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrScreen extends GetView<HomeController> {
  const ScanQrScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('مسح QR للحضور'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller.cameraController,
            onDetect: controller.onDetect,
          ),

          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColor.primaryColor, width: 3),
              ),
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
