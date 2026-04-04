import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';

class DottedLineText extends StatelessWidget {

  const DottedLineText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: DottedLine(
            dashLength: 3,
            dashGapLength: 3,
            lineThickness: 1,
            dashColor: AppColor.secondryColor,
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal:  0.05.w(context)),
          child: Text(
            AppString.or.tr,
            style:Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.secondryColor,fontWeight: FontWeight.w700),
          ),
        ),
        const Expanded(
          child: DottedLine(
            dashLength: 3,
            dashGapLength: 3,
            lineThickness: 1,
            dashColor: AppColor.secondryColor,

          ),
        ),
      ],
    );

  }
}
