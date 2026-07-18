import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/core/widget/custom_button_primary.dart';
import 'package:career/features/vacation/presentation/getx/controller/vacation_controller.dart';
import 'package:career/features/vacation/presentation/widget/custom_drop_down_vacation.dart';
import 'package:career/features/vacation/presentation/widget/custom_text_field_vacation.dart';
import 'package:career/features/vacation/presentation/widget/vacation_attachment_picker.dart';
import 'package:career/features/vacation/presentation/widget/vacation_date_range_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class VacationRequestForm extends StatelessWidget {
  final VacationController controller;

  const VacationRequestForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Lottie.asset(AppAsset.permission, height: 0.2.h(context), width: 500),
        Obx(() {
          return CustomDropDownVacation(
            value: controller.selectedVacation.value,
            items: controller.vacationTypes,
            hint: AppString.selectVacationType.tr,
            onChanged: controller.setSelectedVacationType,
            prefixIcon: Icon(
              Icons.beach_access_outlined,
              color: AppColor.primaryColor,
            ),
            isLoading: controller.isVacationTypesLoading.value,
          );
        }),
        10.verticalSpace(),
        VacationDateRangeRow(controller: controller),
        10.verticalSpace(),
        CustomTextFieldVacation(
          hintText: AppString.numberOfDay.tr,
          textInputType: TextInputType.number,
          controller: controller.durationController,
        ),
        10.verticalSpace(),
        VacationAttachmentPicker(controller: controller),
        15.verticalSpace(),
        Obx(() {
          return CustomButtonPrimary(
            text: AppString.applyNow.tr,
            onTap: controller.submitVacationRequest,
            isLoading: controller.isLoading.value,
          );
        }),
        CustomButtonPrimary(
          text: AppString.showLastVacation.tr,
          onTap: () => Get.toNamed(RoutesName.vacationRequests),
        ),
      ],
    );
  }
}
