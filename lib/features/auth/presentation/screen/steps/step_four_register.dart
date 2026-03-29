import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/auth/presentation/widget/addition_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/class/app_asset.dart';
import '../../../../../core/constant/class/app_string.dart';
import '../../getx/controller/register_controller.dart';
import '../../widget/custom_drop_down_button.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/sub_title_steps.dart';

class StepFourRegister extends GetView<RegisterController> {
  const StepFourRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SubTitleSteps(text: AppString.education.tr,),
        23.verticalSpace(),
        Obx(() {
          return CustomDropdown(
            value: controller.selectedGender.value,
            items: controller.genderItems,
            hint: AppString.level.tr,
            onChanged: controller.setSelectedGender,
            prefixIcon: SvgPicture.asset(AppAsset.level),
          );
        }),
        12.verticalSpace(),
        Obx(() {
          return CustomDropdown(
            value: controller.selectedGender.value,
            items: controller.genderItems,
            hint: AppString.degree.tr,
            onChanged: controller.setSelectedGender,
            prefixIcon: SvgPicture.asset(AppAsset.degree),
          );
        }),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.university,fit: BoxFit.scaleDown,),hintText: AppString.universityName.tr),
        12.verticalSpace(),
        Row(
          children: [
            Obx(() {
              return Expanded(
                child: CustomDropdown(
                  value: controller.selectedGender.value,
                  items: controller.genderItems,
                  hint: AppString.dateFrom.tr,
                  onChanged: controller.setSelectedGender,
                  prefixIcon: SvgPicture.asset(AppAsset.date),
                ),
              );
            }),
            Obx(() {
              return Expanded(
                child: CustomDropdown(
                  value: controller.selectedGender.value,
                  items: controller.genderItems,
                  hint: AppString.dateTo.tr,
                  onChanged: controller.setSelectedGender,
                  prefixIcon: SvgPicture.asset(AppAsset.date),
                ),
              );
            }),
          ],
        ),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.about,fit: BoxFit.scaleDown,),hintText: AppString.about.tr,isComment: true),
        12.verticalSpace(),
        AdditionSection(text: AppString.addAnEducation.tr,onTap: (){},),
        24.verticalSpace(),
        SubTitleSteps(text: AppString.skills.tr),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.skill,fit: BoxFit.scaleDown,),hintText: AppString.skillName.tr),
        12.verticalSpace(),
        Obx(() {
          return CustomDropdown(
            value: controller.selectedGender.value,
            items: controller.genderItems,
            hint: AppString.level.tr,
            onChanged: controller.setSelectedGender,
            prefixIcon: SvgPicture.asset(AppAsset.level),
          );
        }),
        12.verticalSpace(),
        AdditionSection(text: AppString.addASkill.tr,onTap: (){},),
        12.verticalSpace(),
        CustomTextField(prefix: SvgPicture.asset(AppAsset.language,fit: BoxFit.scaleDown,),hintText: AppString.language.tr),
        12.verticalSpace(),
        Obx(() {
          return CustomDropdown(
            value: controller.selectedGender.value,
            items: controller.genderItems,
            hint: AppString.level.tr,
            onChanged: controller.setSelectedGender,
            prefixIcon: SvgPicture.asset(AppAsset.level),
          );
        }),
        12.verticalSpace(),
        AdditionSection(text: AppString.addALanguage.tr,onTap: (){},),
        12.verticalSpace(),

      ],

    );
  }
}
