import 'package:career/core/constant/class/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../getx/controller/onboarding_controller.dart';

class CustomProgressIndicator extends GetView<OnBoardingController> {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          // Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.pages.length,
                  (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: controller.currentPage.value == i ? 21 : 5,
                height: 6,
                decoration: BoxDecoration(
                  color:  AppColor.white,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
