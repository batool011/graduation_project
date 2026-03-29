import 'package:career/core/constant/class/app_size.dart';
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
                    children: [
                      Text(
                          page["title1"]!,
                          style:Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900)
                      ),
                      Text(
                          page["title2"]!,
                          style:Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w900)
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
