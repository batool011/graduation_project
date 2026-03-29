import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.13.w(context),vertical: 0.02.h(context)),
      margin: EdgeInsets.symmetric(horizontal: 0.05.w(context),vertical: 0.02.h(context)),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),child: Row(
      children: [
        SvgPicture.asset(AppAsset.building),
        12.horizontalSpace(),
        Text(AppString.registerAsACompany.tr,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.secondryColor,fontWeight: FontWeight.w500),)
      ],
    ),
    );
  }
}
