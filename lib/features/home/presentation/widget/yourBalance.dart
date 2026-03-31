import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constant/class/app_asset.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_size.dart';

class Yourbalance extends StatelessWidget {
  const Yourbalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.06.w(context)),
      padding: EdgeInsets.symmetric(
          horizontal: 0.06.w(context)
        // vertical: 0.05.h(context),
      ),
      decoration: BoxDecoration(
        color: AppColor.secondryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [

          Text(
            "رصيدك الحالي",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColor.lightBlue.withAlpha(120),
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "3000",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColor.lightBlue.withAlpha(120),
              fontWeight: FontWeight.w800,
            ),
          ),
          Lottie.asset(AppAsset.savingMoney,height: 130)
        ],
      ),
    );
  }
}
