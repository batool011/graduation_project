import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AboutAppContent extends StatelessWidget {
  const AboutAppContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppString.hrManagementApp.tr,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          10.verticalSpace(),
          Lottie.asset(AppAsset.about),
          10.verticalSpace(),
          Text(
            AppString.appDescription.tr,
            style: const TextStyle(fontSize: 16),
          ),
          100.verticalSpace(),
          Text(AppString.appVersion.tr),
        ],
      ),
    );
  }
}