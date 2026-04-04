import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constant/class/app_asset.dart';
import '../../../../core/constant/class/app_color.dart';

class InformationOfProfile extends StatelessWidget {
  const InformationOfProfile({super.key, required this.text, required this.percent});
final String text;
final String percent;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 0.04.w(context),vertical: 0.02.h(context)),
      margin: EdgeInsets.symmetric(horizontal: 0.04.w(context),vertical: 0.008.h(context)),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20)
      ),child: Row(
      children: [
        SvgPicture.asset(AppAsset.edites),
        11.horizontalSpace(),
        Text(text,style: Theme.of(context).textTheme.bodySmall,),
        Spacer(),
        Text(percent,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.primaryColor),)
      ],
    ),
    );
  }
}
