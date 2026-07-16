import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/controller/onboarding_controller.dart';
import '../widget/custom_bottom_container.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: controller.pages.length,
            onPageChanged: controller.onPageChanged,
            itemBuilder: (context, index) {
              final page = controller.pages[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        page["title1"]!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          color: AppColor.primaryColor,
                          height: 1.1,
                        ),
                      ),
                      Text(
                        page["title2"]!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          color: AppColor.primaryColor,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(page["image"]!),
                  200.verticalSpace()
                ],
              );
            },
          ),
          CustomBottomContainer(),
        ],
      )
    );
  }
}