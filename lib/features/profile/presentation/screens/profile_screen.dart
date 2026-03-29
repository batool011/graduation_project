import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_button_primary.dart';
import 'package:career/core/widget/under_line_text.dart';
import 'package:career/features/profile/presentation/widget/information_of_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../widget/step_progress_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
        appBar: PreferredSize(preferredSize: Size(double.infinity,70),
            child: CustomAppBar(text: AppString.myProfile.tr,)),
        body: ListView(
        children: [
          StepProgressBar(steps: 5,),
          Image.asset(AppAsset.profileImage,height: 200,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add,size: 14,color: AppColor.lightCyan,),
              UnderLineText(text: AppString.addAPhoto.tr),
            ],
          ),
          20.verticalSpace(),
          InformationOfProfile(text: AppString.generalInformation.tr, percent: '100%',),
          InformationOfProfile(text: AppString.jobDetails.tr, percent: '100%',),
          InformationOfProfile(text: AppString.contactInformation.tr, percent: '100%',),
          InformationOfProfile(text: AppString.skills.tr, percent: '100%',),
          InformationOfProfile(text: AppString.language.tr, percent: '100%',),
          InformationOfProfile(text: AppString.workExperiences.tr, percent: '100%',),
          CustomButtonPrimary(text: AppString.exportCv.tr)
        ],
      )
    );
  }
}
