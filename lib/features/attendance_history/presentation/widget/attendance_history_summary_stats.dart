import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/attendance_history/presentation/widget/summary_state_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/controller/attendance_history_controller.dart';

class AttendanceHistorySummaryStats extends StatelessWidget {
  const AttendanceHistorySummaryStats({super.key, required this.controller});

  final AttendanceHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: SummaryStatCard(
              title: 'الإجازات',
              value: controller.vacationDaysCount,
              icon: Icons.beach_access_rounded,
              tint: AppColor.blue ,
            ),
          ),
          10.horizontalSpace(),
          Expanded(
            child: SummaryStatCard(
              title: 'التأخير',
              value: controller.lateDaysCount,
              icon: Icons.schedule_rounded,
              tint: AppColor.orange ,
            ),
          ),
          10.horizontalSpace(),
          Expanded(
            child: SummaryStatCard(
              title: 'العمل الإضافي',
              value: controller.overtimeDaysCount,
              icon: Icons.trending_up_rounded,
              tint:  AppColor.green,
            ),
          ),
        ],
      );
    });
  }
}

