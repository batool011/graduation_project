import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../widget/about_app_content.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.aboutUs.tr),
      ),
      body: const AboutAppContent(),
    );
  }
}