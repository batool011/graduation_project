import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/under_line_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';

class FirstCompanyContainer extends StatelessWidget {
  const FirstCompanyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.04.w(context),vertical: 0.02.h(context)),
      margin: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
      decoration: BoxDecoration(
          color: AppColor.secondryColor,
          borderRadius: BorderRadius.circular(23)
      ),
      child:  Row(
        children: [
          Text("company name",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500,fontSize: 18),),
          Spacer(),
          SvgPicture.asset(AppAsset.chat),
          4.horizontalSpace(),
          UnderLineText(text: AppString.chatWith.tr)
        ],
      ),);
  }
}
