import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/class/app_asset.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_size.dart';

class Statics extends StatelessWidget {
  const Statics({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 0.4.w(context),
          margin: EdgeInsets.symmetric(horizontal: 0.03.w(context)),
          padding: EdgeInsets.symmetric(
              vertical: 0.03.h(context),
              horizontal: 0.03.w(context)
          ),
          decoration: BoxDecoration(
            color: AppColor.lightBlue.withAlpha(120),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Image.asset(AppAsset.star,height: 20,),
              Text(
                "نقاطك ",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.secondryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 10
                ),
              ),
              Text(
                "3000",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.secondryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 10
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 0.4.w(context),
          margin: EdgeInsets.symmetric(horizontal: 0.03.w(context)),
          padding: EdgeInsets.symmetric(
              vertical: 0.03.h(context),
              horizontal: 0.03.w(context)
          ),
          decoration: BoxDecoration(
            color: AppColor.lightBlue.withAlpha(120),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Text(
                "الخصومات",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.secondryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 10
                ),
              ),
              Text(
                "3000",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.secondryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 10
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
