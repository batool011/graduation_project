import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity,70),
          child: CustomAppBar(text: AppString.aboutUs.tr,)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "HR Management Application",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            10.verticalSpace(),
            Lottie.asset(AppAsset.about),
            10.verticalSpace(),
            Text(
              "This application helps employees manage attendance, savings, leave requests, rewards, and HR services in one smart platform.",
              style: TextStyle(fontSize: 16),
            ),
             100.verticalSpace(),
            Text("Version: 1.0.0"),
          ],
        ),
      ),
    );
  }
}