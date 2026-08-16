import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/attendance_history/presentation/widget/summary_state_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/controller/attendance_history_controller.dart';

class AttendanceHistorySummaryStats extends StatelessWidget {
  const AttendanceHistorySummaryStats({
    super.key,
    required this.controller,
  });

  final AttendanceHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: SummaryStatCard(
                title: AppString.late.tr,
                value: controller.lateDaysCount,
                icon: Icons.schedule_rounded,
                tint: AppColor.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SummaryStatCard(
                title: AppString.overtime.tr,
                value: controller.overtimeDaysCount,
                icon: Icons.trending_up_rounded,
                tint: AppColor.green,
              ),
            ),
          ],
        ),
      );
    });
  }
}