import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/core/widget/under_line_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../getx/controller/onboarding_controller.dart';
import 'costom_progress_indicator.dart';
import '../../../../core/widget/custom_button_secondry.dart';

class CustomBottomContainer extends GetView<OnBoardingController> {
  const CustomBottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: double.infinity,
        padding:  EdgeInsets.symmetric(vertical: 0.09.h(context),horizontal: 0.05.w(context)),
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
        ),
        child: Obx(() {
          final page = controller.pages[controller.currentPage.value];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                page["subtitle"]!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.secondryColor),
              ),
              39.verticalSpace(),
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ CustomButtonSecondry(text: AppString.getStarted.tr,),CustomProgressIndicator(),],
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Get.toNamed(RoutesName.login);
                },
                child: UnderLineText(text: AppString.loginNow.tr)
              )

            ],
          );
        }),
      ),
    );
  }
}
