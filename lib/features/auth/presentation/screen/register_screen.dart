import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/widget/custom_button_secondry.dart';
import 'package:career/core/widget/under_line_text.dart';
import 'package:career/features/auth/presentation/screen/steps/step_one_register.dart';
import 'package:career/features/auth/presentation/screen/steps/step_three_register.dart';
import 'package:career/features/auth/presentation/screen/steps/step_two_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_string.dart';
import '../getx/controller/register_controller.dart';
import '../widget/custom_title_auth.dart';
import '../widget/step_progress_bar.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Column(
          children: [
            CustomTitleAuth(
              text1: AppString.findYourDreamJob.tr,
              text2: AppString.loginHere.tr,
            ),

            20.verticalSpace(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
              child: StepProgressBar(
                steps: controller.totalSteps,
                currentStep: controller.currentStep.value,
              ),
            ),

            20.verticalSpace(),

            Expanded(child: _buildStepScreen(controller.currentStep.value)),
          ],
        );
      }),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(color: AppColor.primaryColor),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.05.w(context)),
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                controller.currentStep.value != 0
                    ? GestureDetector(
                      onTap:
                          controller.isLoading.value
                              ? null
                              : () {
                                controller.previousStep();
                              },
                      child: Row(
                        children: [
                          SvgPicture.asset(AppAsset.previous),
                          6.horizontalSpace(),
                          UnderLineText(text: AppString.previous.tr),
                        ],
                      ),
                    )
                    : const SizedBox(),
                CustomButtonSecondry(
                  text: AppString.Continue.tr,
                  isLoading:
                      controller.currentStep.value ==
                          controller.totalSteps - 1 &&
                      controller.isLoading.value,
                  onTap:
                      controller.isLoading.value
                          ? null
                          : () {
                            if (controller.currentStep.value <
                                controller.totalSteps - 1) {
                              controller.nextStep();
                            } else {
                              controller.register();
                            }
                          },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildStepScreen(int step) {
    switch (step) {
      case 0:
        return StepOneRegister();
      case 1:
        return StepTwoRegister();
      case 2:
        return StepThreeRegister();
      default:
        return const Center(child: Text("Unknown Step"));
    }
  }
}
