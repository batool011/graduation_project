import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:career/features/notification/presentation/widget/custom_notification_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../core/constant/class/app_string.dart';
import '../../../../../../core/widget/under_line_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity,70),
          child: CustomAppBar(text: AppString.notifications.tr,)),
      backgroundColor: AppColor.scaffoldColor,
      body: Column(
        children: [
          8.verticalSpace(),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 0.05.w(context),vertical: 0.005.h(context)),
            child: Row(children: [
              Text("10 items"),
              Spacer(),
              Icon(Icons.delete_outline,color: AppColor.errorColor,size: 20,),
              4.horizontalSpace(),
              UnderLineText(text: AppString.deleteAll.tr),
            ],),
          ),
          16.verticalSpace(),
          Expanded(
              child: ListView(
                children: [
                  Lottie.asset(AppAsset.bell,height: 200),
                  CustomNotificationContainer(),
                  10.verticalSpace(),
                  CustomNotificationContainer(),
                  10.verticalSpace(),

                  CustomNotificationContainer()
                ],
              )
          )
        ],
      ),
    );
  }
}
