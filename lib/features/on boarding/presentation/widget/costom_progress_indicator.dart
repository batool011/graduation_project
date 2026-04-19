import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.pages.length,
                  (i) => Container(
                margin:  EdgeInsets.symmetric(horizontal: 0.002.h(context)),
                width: controller.currentPage.value == i ? 0.06.w(context) : 0.015.w(context),
                height: 0.007.h(context),
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
