import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/features/vacation/presentation/getx/controller/vacation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/custom_drop_down_button.dart';

class VacationScreen extends GetView<VacationController> {
  const VacationScreen({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: PreferredSize(preferredSize: Size(double.infinity,70),
        child: CustomAppBar(text: AppString.leaveRequest.tr,)),
    body: ListView(
      children: [
       Lottie.asset(AppAsset.calendar,height: 200,width: 500),
        Obx(() {
          return CustomDropdown(
            value: controller.selectedVacation.value,
            items: controller.vacationType,
            hint: AppString.selectGender.tr,
            onChanged: controller.setSelectedGender,
            prefixIcon: Icon(Icons.beach_access),
          );
        }),
        Row(
          children: [
            Obx(() {
              return Expanded(
                child: CustomDropdown(
                  value: controller.selectedVacation.value,
                  items: controller.vacationType,
                  hint: AppString.dateFrom.tr,
                  onChanged: controller.setSelectedGender,
                  prefixIcon: Icon(Icons.beach_access),
                ),
              );
            }),
            Obx(() {
              return Expanded(
                child: CustomDropdown(
                  value: controller.selectedVacation.value,
                  items: controller.vacationType,
                  hint: AppString.dateTo.tr,
                  onChanged: controller.setSelectedGender,
                  prefixIcon: Icon(Icons.beach_access),
                ),
              );
            }),
          ],
        ),

      ],
    ),
  );
  }
}
