import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/class/app_asset.dart';
import '../../../../../core/constant/class/app_string.dart';
import '../../getx/controller/register_controller.dart';
import '../../widget/custom_drop_down_button.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/sub_title_steps.dart';

class StepTwoRegister extends GetView<RegisterController> {
  const StepTwoRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SubTitleSteps(text: AppString.jobDetails.tr,),

        23.verticalSpace(),
        Obx(() {
          return CustomDropdown(
            value: controller.selectedGender.value,
            items: controller.genderItems,
            hint: AppString.jobTitle.tr,
            onChanged: controller.setSelectedGender,
            prefixIcon: SvgPicture.asset(AppAsset.jobTitle),
          );
        }),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.about,fit: BoxFit.scaleDown,),hintText: AppString.jobDescription.tr,isComment: true,),
        12.verticalSpace(),
        Obx(() {
          return CustomDropdown(
            value: controller.selectedGender.value,
            items: controller.genderItems,
            hint: AppString.actualWork.tr,
            onChanged: controller.setSelectedGender,
            prefixIcon: SvgPicture.asset(AppAsset.actualWork),
          );
        }),
        12.verticalSpace(),
        Obx(() {
          return CustomDropdown(
            value: controller.selectedGender.value,
            items: controller.genderItems,
            hint: AppString.workTypePrefered.tr,
            onChanged: controller.setSelectedGender,
            prefixIcon: SvgPicture.asset(AppAsset.workTypePrefered),
          );
        }),
        12.verticalSpace(),
        Obx(() {
          return CustomDropdown(
            value: controller.selectedGender.value,
            items: controller.genderItems,
            hint: AppString.sitePrefered.tr,
            onChanged: controller.setSelectedGender,
            prefixIcon: SvgPicture.asset(AppAsset.sitePrefered),
          );
        }),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.uploadCv,fit: BoxFit.scaleDown,),hintText: AppString.uploadCv.tr),

      ],
    );
  }
}
