import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/attendance_history/presentation/widget/quick_action_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/controller/attendance_history_controller.dart';
import 'attendance_history_summary_stats.dart';
import 'attendance_period_dialog.dart';
import 'count_pill.dart';

class AttendanceHistoryHeader extends StatelessWidget {
  const AttendanceHistoryHeader({
    super.key,
    required this.controller,
    required this.totalCount,
  });

  final AttendanceHistoryController controller;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColor.grey.withOpacity(0.16),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
            spreadRadius: -14,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.primaryColor,
                        AppColor.primaryColor.withOpacity(0.78),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryColor.withOpacity(0.22),
                        blurRadius: 14,
                        offset: const Offset(0, 8),
                        spreadRadius: -8,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.attendanceHistory.tr,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColor.black,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Obx(() {
                        return Row(
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 15,
                              color: AppColor.blackLight,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                controller.monthTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  color: AppColor.blackLight,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                CountPill(count: totalCount, label: AppString.record.tr),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.tune_rounded,
                    size: 18,
                    color: AppColor.primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      AppString.changePeriod.tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  QuickActionChip(
                    icon: Icons.date_range_rounded,
                    label: AppString.changePeriod.tr,
                    onTap: () => AttendancePeriodDialog.show(
                      context,
                      controller,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            AttendanceHistorySummaryStats(controller: controller),
          ],
        ),
      ),
    );
  }
}