import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/setting/presentation/widget/custom_card_my_job.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_asset.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/router/routes_name.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/under_line_text.dart';

class MyJobScreen extends StatelessWidget {
  const MyJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity,70),
          child: CustomAppBar(text: AppString.myJobs.tr,)),
      backgroundColor: AppColor.scaffoldColor,
      body:  Column(
        children: [
          15.verticalSpace(),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 0.06.w(context),vertical: 0.005.h(context)),
            child: Row(children: [
              Text("10 items"),
              Spacer(),
              SvgPicture.asset(AppAsset.sort),
              4.horizontalSpace(),
              UnderLineText(text: AppString.sortBy.tr),
            ],),
          ),
          16.verticalSpace(),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                itemCount: 30,
                itemBuilder: (context,index){
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 0.05.w(context),vertical: 0.005.h(context)),
                    child: GestureDetector(
                        onTap: (){Get.toNamed(RoutesName.detailJob);},
                        child: CustomCardMyJob()),
                  );
                }),
          )
        ],
      ),
    );
  }
}
