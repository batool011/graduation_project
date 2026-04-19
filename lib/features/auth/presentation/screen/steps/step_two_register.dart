import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/class/app_asset.dart';
import '../../../../../core/constant/class/app_string.dart';
import '../../getx/controller/register_controller.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/sub_title_steps.dart';

class StepTwoRegister extends GetView<RegisterController> {
  const StepTwoRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SubTitleSteps(text: AppString.contactInformation.tr,),

        23.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.location,fit: BoxFit.scaleDown,),hintText: AppString.address.tr,controller: controller.addressController,),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.number,fit: BoxFit.scaleDown,),hintText: AppString.contactNumber.tr,controller: controller.numberController,),
        12.verticalSpace(),
        CustomTextField(
          prefix: SvgPicture.asset(AppAsset.password, fit: BoxFit.scaleDown),
          hintText: AppString.password.tr,
          controller: controller.passwordController,
          obscureText: true,
        ),
        12.verticalSpace(),
        CustomTextField(
          prefix: SvgPicture.asset(AppAsset.password, fit: BoxFit.scaleDown),
          hintText: AppString.confirmPassword.tr,
          controller: controller.confirmPasswordController,
          obscureText: true,
        ),

      ],
    );
  }
}
