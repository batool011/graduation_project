import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_asset.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/router/routes_name.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/custom_card.dart';
import '../../../../core/widget/custom_text_field_search.dart';
import '../../../../core/widget/custom_white_container.dart';
import '../../../../core/widget/under_line_text.dart';

class FindJobScreen extends StatelessWidget {
  const FindJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity,70),
          child: CustomAppBar(text: AppString.findJobs.tr,)),
      backgroundColor: AppColor.scaffoldColor,
      body:  Column(
        children: [
          15.verticalSpace(),
          Row(
            children: [
              Expanded(child: CustomTextFieldSearch()),
              CustomWhiteContainer(icon: AppAsset.filter,),
            ],
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 0.05.w(context),vertical: 0.005.h(context)),
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
                    padding:  EdgeInsets.symmetric(horizontal: 0.05.w(context)),
                    child: GestureDetector(
                        onTap: (){Get.toNamed(RoutesName.detailJob);},
                        child: CustomCard()),
                  );
                }),
          )
        ],
      ),
    );
  }
}
