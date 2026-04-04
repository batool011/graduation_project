import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/class/app_color.dart';

class FirstPositionContainer extends StatelessWidget {
  const FirstPositionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.04.w(context),vertical: 0.013.h(context)),
      margin: EdgeInsets.symmetric(horizontal: 0.04.w(context)),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(23)
      ),
      child:  Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0.045.w(context),vertical: 0.015.h(context)),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text("Full time",style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColor.primaryColor),),
          ),
          14.horizontalSpace(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0.045.w(context),vertical: 0.015.h(context)),
            decoration: BoxDecoration(
              color: AppColor.secondryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text("On Site",style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColor.secondryColor),),
          ),
          Spacer(),
          Text("10k/month",style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w700,color: AppColor.primaryColor),),

        ],
      ),)
    ;
  }
}
