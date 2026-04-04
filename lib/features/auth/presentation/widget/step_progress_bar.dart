import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/core/widget/under_line_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepProgressBar extends StatelessWidget {
  final int steps;
  final int currentStep;

  const StepProgressBar({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {

    final int bars = steps - 1;

    double percent = (currentStep / bars) * 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(bars, (index) {
            return Expanded(
              child: Container(
                height: 5,
                margin: EdgeInsets.only(right: index == bars - 1 ? 0 : 6),
                decoration: BoxDecoration(
                  color: index < currentStep ? AppColor.secondryColor : AppColor.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }),
        ),

        10.verticalSpace(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${percent.toInt()}%",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColor.primaryColor),
            ),
            GestureDetector(
                onTap: (){
                  Get.toNamed(RoutesName.home);
                },
                child: UnderLineText(text: AppString.skip.tr)),
          ],
        )
      ],
    );
  }
}
