import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/auth/presentation/widget/country_drop_down_button.dart';
import 'package:career/features/auth/presentation/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/class/app_asset.dart';
import '../../getx/controller/register_controller.dart';
import '../../widget/custom_drop_down_button.dart';
import '../../widget/sub_title_steps.dart';

class StepOneRegister extends GetView<RegisterController> {
  const StepOneRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
       SubTitleSteps(text: AppString.generalInformation.tr,),
        23.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.fullName,fit: BoxFit.scaleDown,),hintText: AppString.fullName.tr),
        12.verticalSpace(),
        CountryDropdown(),
        12.verticalSpace(),
        Obx(() {
          return CustomDropdown(
            value: controller.selectedGender.value,
            items: controller.genderItems,
            hint: AppString.selectGender.tr,
            onChanged: controller.setSelectedGender,
            prefixIcon: SvgPicture.asset(AppAsset.gender),
          );
        }),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.age,fit: BoxFit.scaleDown,),hintText: AppString.age.tr,textInputType: TextInputType.number  ,),
       12.verticalSpace(),
        Obx(() {
          return CustomDropdown(
            value: controller.selectedGender.value,
            items: controller.genderItems,
            hint: AppString.dateOfBirth.tr,
            onChanged: controller.setSelectedGender,
            prefixIcon: SvgPicture.asset(AppAsset.dateOfBirth),
          );
        }),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.about,fit: BoxFit.scaleDown,),hintText: AppString.about.tr,isComment: true),

      ],
    );
  }
}
