import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/core/widget/custom_button_primary.dart';
import 'package:career/core/widget/under_line_text.dart';
import 'package:career/features/auth/presentation/widget/custom_auth_button.dart';
import 'package:career/features/auth/presentation/widget/custom_text_auth.dart';
import 'package:career/features/auth/presentation/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../widget/custom_title_auth.dart';
import '../widget/dotted_line_text.dart';

class CreateNewAccountScreen extends StatelessWidget {
  const CreateNewAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Stack(
        children: [
          ListView(
            children: [
              CustomTitleAuth(text1: AppString.findYourDreamJob.tr, text2: AppString.newAccount.tr,),
              CustomTextAuth(text: AppString.pleaseEnterYourEmailAddressToVerifyIt.tr),

              CustomTextField(prefix: SvgPicture.asset(AppAsset.email,fit: BoxFit.scaleDown,),hintText: AppString.emailAddress.tr),


              CustomButtonPrimary(text: AppString.Continue.tr,onTap: (){Get.toNamed(RoutesName.verify);},),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.05.h(context),horizontal: 0.05.w(context)),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DottedLineText(),
                    30.verticalSpace(),
                    CustomAuthButton(text: AppString.accessYourAccount.tr, icons: AppAsset.accessAcount),
                    CustomAuthButton(text: AppString.continueWithGoogle.tr, icons: AppAsset.google),
                    30.verticalSpace(),
                    UnderLineText(text: AppString.doItLater.tr)
                  ]
              ),
            ),
          )
        ],
      ),
    );
  }
}
