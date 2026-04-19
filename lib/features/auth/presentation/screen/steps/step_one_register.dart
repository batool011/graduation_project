import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/auth/presentation/widget/company_drop_down_button.dart';
import 'package:career/features/auth/presentation/widget/country_drop_down_button.dart';
import 'package:career/features/auth/presentation/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/class/app_asset.dart';
import '../../../../../core/widget/custom_date_picker_field.dart';
import '../../getx/controller/register_controller.dart';
import '../../../../../core/widget/custom_drop_down_button.dart';
import '../../widget/sub_title_steps.dart';

class StepOneRegister extends GetView<RegisterController> {
  const StepOneRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SubTitleSteps(text: AppString.generalInformation.tr),
        23.verticalSpace(),
        CustomTextField(
          prefix: SvgPicture.asset(AppAsset.fullName, fit: BoxFit.scaleDown),
          hintText: AppString.fullName.tr,
          controller: controller.fullNameController,
        ),
        12.verticalSpace(),
        CustomTextField(
          prefix: SvgPicture.asset(AppAsset.profile, fit: BoxFit.scaleDown),
          hintText: AppString.userName.tr,
          controller: controller.userNameController,
          textInputType: TextInputType.name,
        ),
        12.verticalSpace(),
        CompanyDropdown(),
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
        Obx(() {
          return CustomDropdown(
            value: controller.selectedMaritalStatus.value,
            items: controller.maritalStatusItems,
            hint: AppString.maritalStatus.tr,
            onChanged: controller.setSelectedMaritalStatus,
            prefixIcon: SvgPicture.asset(AppAsset.maritalStatus),
          );
        }),
        12.verticalSpace(),
        CustomTextField(
          prefix: SvgPicture.asset(AppAsset.age, fit: BoxFit.scaleDown),
          hintText: AppString.age.tr,
          textInputType: TextInputType.number,
          controller: controller.ageController,
        ),
        12.verticalSpace(),
        CustomDatePickerField(
          hintText: AppString.dateOfBirth.tr,
          controller: controller.dateOfBirthController,
          prefixIcon: SvgPicture.asset(AppAsset.dateOfBirth),
          onTap: () => controller.pickDate(context, controller.dateOfBirthController),
        ),
        12.verticalSpace(),
      ],
    );
  }
}
