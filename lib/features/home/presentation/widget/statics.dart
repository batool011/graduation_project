import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/class/app_asset.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_size.dart';

class Statics extends StatelessWidget {
  final String sale;
  final String point;
  const Statics({super.key, required this.sale, required this.point});

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(AppAsset.star,height: 20,),
              Text(
                AppString.yourPoint,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.secondryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 12
                ),
              ),
              Text(
               point,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.secondryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 12
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppString.yourSale,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.secondryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 12
                ),
              ),
              Text(
                "3000",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.secondryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 12
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
