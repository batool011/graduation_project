import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_color.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_button_primary.dart';
import '../../../../core/widget/under_line_text.dart';
import '../widget/custom_text_auth.dart';
import '../widget/custom_title_auth.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Stack(
        children: [
          ListView(
            children: [
              CustomTitleAuth(text1: AppString.findYourDreamJob.tr, text2: AppString.loginHere.tr,),
              Row(
                children: [
                  CustomTextAuth(text: AppString.enterTheCodeSentTo.tr),
                  12.horizontalSpace(),
                  UnderLineText(text: AppString.someoneEmail.tr)
                ],
              ),
        12.verticalSpace(),
        OtpTextField(
          numberOfFields: 5,
          showFieldAsBox: true,
          fillColor: AppColor.lightGrey,
          filled: true,
          enabledBorderColor: Colors.transparent,
          borderColor: Colors.transparent,

          borderRadius: BorderRadius.circular(27),

          fieldWidth:56,
          fieldHeight: 54,
          textStyle: const TextStyle(fontSize: 20),

          onSubmit: (String code) {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Verification Code"),
                  content: Text("Code entered is $code"),
                ));
          },
        ),
              12.verticalSpace(),

        CustomButtonPrimary(text: AppString.Continue.tr,onTap: (){Get.toNamed(RoutesName.register);},),


            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 0.06.h(context),horizontal: 0.05.w(context)),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                   SvgPicture.asset(AppAsset.alarm),
                    29.verticalSpace(),
                    Text(AppString.youCanResendTheCodeWithin45Seconds.tr,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.secondryColor.withAlpha(50)),),
                    13.verticalSpace(),
                    UnderLineText(text: AppString.resendCode.tr)
                  ]
              ),
            ),
          )
        ],
      ),
    );
  }
}
