import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/widget/under_line_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCardMyJob extends StatelessWidget {
  const CustomCardMyJob({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Image.asset(AppAsset.neuw,height: 100,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("DreamWeb",style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColor.blackLight,fontSize: 10),),
                  5.verticalSpace(),
                  Text("Sr. UI UX Designer",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w700),),
                  6.verticalSpace(),
                  Row(children: [
                    SvgPicture.asset(AppAsset.locationBold,height: 10,),
                    6.5.horizontalSpace(),
                    Text("Damascus, Syria",style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColor.blackLight,fontSize: 10),),
                    60.horizontalSpace(),
                    UnderLineText(text: 'AppString')

                  ],
                  ),
                ],
              ),

            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0.05.w(context),vertical: 0.013.h(context)),
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20))
            ),
            child: Text("10k/month",style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 10,fontWeight: FontWeight.w700),),
          ),
        ),
      ],
    );
  }
}
