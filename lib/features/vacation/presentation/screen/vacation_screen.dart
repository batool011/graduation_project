import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/vacation/presentation/getx/controller/vacation_controller.dart';
import 'package:career/features/vacation/presentation/widget/custom_drop_down_vacation.dart';
import 'package:career/features/vacation/presentation/widget/custom_text_field_vacation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';

class VacationScreen extends GetView<VacationController> {
  const VacationScreen({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: PreferredSize(preferredSize: Size(double.infinity,70),
        child: CustomAppBar(text: AppString.leaveRequest.tr,)),
    body: ListView(
      children: [
       Lottie.asset(AppAsset.calendar,height: 0.2.h(context),width: 500),
        Obx(() {
          return CustomDropDownVacation(
            value: controller.selectedVacation.value,
            items: controller.vacationType,
            hint: AppString.selectVacationType.tr,
            onChanged: controller.setSelectedGender,
            prefixIcon: Icon(Icons.beach_access_outlined),
          );
        }),
        10.verticalSpace(),
        Row(
          children: [
            Obx(() {
              return Expanded(
                child: CustomDropDownVacation(
                  value: controller.selectedVacation.value,
                  items: controller.vacationType,
                  hint: AppString.dateFrom.tr,
                  onChanged: controller.setSelectedGender,
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              );
            }),
            Obx(() {
              return Expanded(
                child: CustomDropDownVacation(
                  value: controller.selectedVacation.value,
                  items: controller.vacationType,
                  hint: AppString.dateTo.tr,
                  onChanged: controller.setSelectedGender,
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              );
            }),
          ],
        ),
        10.verticalSpace(),
        CustomTextFieldVacation(hintText: AppString.reason.tr,),
        10.verticalSpace(),
        CustomTextFieldVacation(hintText: AppString.numberOfDay.tr,textInputType: TextInputType.number,),
        10.verticalSpace(),
        CustomTextFieldVacation( hintText: controller.selectedFiles.isEmpty
            ? AppString.uploadAttachment.tr
            : "${controller.selectedFiles.length} ${AppString.filesSelected}",readOnly: true,prefix: Icon(Icons.attach_file),onTap: (){controller.pickFiles();},),
        Obx(() {
          return Column(
            children: controller.selectedFiles.map((file) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Icon(Icons.insert_drive_file, size: 20),
                    SizedBox(width: 8),
                    Expanded(child: Text(file, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              );
            }).toList(),
          );
        })
      ],
    ),
  );
  }
}
