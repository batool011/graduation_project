import 'package:career/features/home/presentation/screen/scan_qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_size.dart';

class CustomButtonSign extends StatelessWidget {
  const CustomButtonSign({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
mainAxisAlignment: MainAxisAlignment.center,
            children: [
        GestureDetector(
        onTap: () {Get.to(ScanQrScreen(scanMode: 'in',));},
          child: Container(
            width: 0.45.w(context),
            padding: EdgeInsets.symmetric(horizontal: 0.02.w(context),vertical: 0.02.h(context)),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text("تسجيل دحول ",style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColor.primaryColor,fontSize: 12),)),
          ),
        ),
        5.horizontalSpace(),
        GestureDetector(
          onTap: () {Get.to(ScanQrScreen(scanMode: 'out',));},
          child: Container(
            width: 0.45.w(context),
            padding: EdgeInsets.symmetric(horizontal: 0.02.w(context),vertical: 0.02.h(context)),
            decoration: BoxDecoration(
              color: AppColor.secondryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text("تسجيل حروج",style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColor.secondryColor,fontSize: 12),)),
          ),
        ),
      ],
    );
  }
}
