import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_date_picker_field.dart';
import 'package:career/features/vacation/presentation/getx/controller/vacation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VacationDateRangeRow extends StatelessWidget {
  final VacationController controller;

  const VacationDateRangeRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() {
          return Expanded(
            child: CustomDatePickerField(
              hintText: AppString.dateFrom.tr,
              value: controller.dateFrom.value,
              prefixIcon: const Icon(
                Icons.calendar_today_outlined,
                color: AppColor.primaryColor,
                size: 20,
              ),
              onTap: () => controller.selectDateFrom(context),
            ),
          );
        }),
        Obx(() {
          return Expanded(
            child: CustomDatePickerField(
              hintText: AppString.dateTo.tr,
              value: controller.dateTo.value,
              prefixIcon: const Icon(
                Icons.calendar_today_outlined,
                color: AppColor.primaryColor,
                size: 20,
              ),
              onTap: () => controller.selectDateTo(context),
            ),
          );
        }),
      ],
    );
  }
}
