import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../getx/controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAsset.splash,fit: BoxFit.cover,width: double.infinity,height: double.infinity,),
          Container(
            color: AppColor.primaryColor.withAlpha(220),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAsset.logo,alignment: Alignment.center,),
                20.verticalSpace(),
                Text(AppString.careerNow.tr,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColor.white,fontWeight: FontWeight.w900))
              ],
            ),
          )
        ],
      ),
    );
  }
}
