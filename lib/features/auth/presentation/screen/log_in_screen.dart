import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/core/widget/custom_button_primary.dart';
import 'package:career/core/widget/under_line_text.dart';
import 'package:career/features/auth/presentation/widget/custom_auth_button.dart';
import 'package:career/features/auth/presentation/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../getx/controller/login_controller.dart';
import '../widget/custom_text_auth.dart';
import '../widget/custom_title_auth.dart';
import '../widget/dotted_line_text.dart';

class LogInScreen extends GetView<LoginController> {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ListView(
            children: [
              CustomTitleAuth(text1: AppString.findYourDreamJob.tr, text2: AppString.loginHere.tr,),
              CustomTextAuth(text: AppString.pleaseEnterYourAccountInformationToContinue.tr),
              CustomTextField(prefix: SvgPicture.asset(AppAsset.email,fit: BoxFit.scaleDown,),hintText: AppString.emailAddress.tr,controller: controller.userName,),
              16.verticalSpace(),
              Obx(() {
                return CustomTextField(
                  prefix: SvgPicture.asset(AppAsset.password,fit: BoxFit.scaleDown,),
                  hintText: AppString.password.tr,
                  controller: controller.password,
                  obscureText: !controller.isEyeOpen.value,
                  suffixIcon: IconButton(
                    onPressed: controller.toggleEye,
                    icon: Icon(
                      controller.isEyeOpen.value ? Icons.visibility : Icons.visibility_off,
                      color: AppColor.secondryColor,
                    ),
                  ),
                );
              }),
              7.verticalSpace(),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:  0.12.w(context) ),
                child: UnderLineText(text: AppString.forgetPassword.tr),
              ),
              Obx(() {
                return CustomButtonPrimary(
                  text: AppString.login.tr,
                  isLoading: controller.isLoading.value,
                  onTap: controller.isLoading.value ? null : controller.login,
                );
              }),

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
                    CustomAuthButton(text: AppString.createAFreeAccountNow.tr, icons: AppAsset.createNewAccount,onTap: (){Get.toNamed(RoutesName.register);},),
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
