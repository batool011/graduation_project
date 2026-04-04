import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/core/widget/under_line_text.dart';
import 'package:career/features/setting/presentation/widget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../widget/custom_list_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: PreferredSize(preferredSize: Size(double.infinity,70),
          child: CustomAppBar(text: AppString.setting.tr,)),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.05.w(context),vertical: 0.02.h(context)),
            child: Row(
              children: [
                Text("User Name",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24,fontWeight: FontWeight.bold),),
                Spacer(),
                UnderLineText(text: AppString.accountSettings.tr)
              ],
            ),
          ),
          12.verticalSpace(),
          Container(
            height: .9.h(context),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(topLeft:Radius.circular(20) ,topRight:Radius.circular(20) )
            ),
            child:Padding(
              padding:  EdgeInsetsDirectional.only(start:  0.05.w(context)),
              child: Column(
                children: [
                  Lottie.asset(AppAsset.setting,height: 250),
                  10.verticalSpace(),
                  CustomListTile(leading: AppAsset.languageSetting, title: AppString.language.tr, onTap: (){},),
                  Divider(color: AppColor.secondryColor,endIndent: 0.04.w(context),indent: 0.04.w(context),thickness: 0.7,),
                  CustomListTile(leading: AppAsset.helpSetting, title:AppString.helpCenter.tr , onTap: (){Get.toNamed(RoutesName.helpCenter);},),
                  Divider(color: AppColor.secondryColor,endIndent: 0.04.w(context),indent: 0.04.w(context),thickness: 0.7,),
                  CustomListTile(leading: AppAsset.aboutUsSetting, title: AppString.aboutUs.tr, onTap: (){Get.toNamed(RoutesName.aboutApp);},),
                  Divider(color: AppColor.secondryColor,endIndent: 0.04.w(context),indent: 0.04.w(context),thickness: 0.7,),
                  CustomListTile(leading: AppAsset.logOutSetting, title: AppString.logOut.tr, onTap: (){},),
              
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
