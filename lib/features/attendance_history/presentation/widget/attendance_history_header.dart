import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
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
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.white,
            AppColor.white.withOpacity(0.92),
            AppColor.lightGrey.withOpacity(0.78),
          ],
        ),
        border: Border.all(color: AppColor.grey.withOpacity(0.55)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(0.045.w(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.primaryColor,
                        AppColor.primaryColor.withOpacity(0.82),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryColor.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
               14.horizontalSpace(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'سجل الحضور',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColor.black,
                          height: 1.1,
                        ),
                      ),
                     6.verticalSpace(),
                      Obx(() {
                        return Text(
                          controller.monthTitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColor.blackLight,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                CountPill(count: totalCount, label: 'سجل'),
              ],
            ),
            18.verticalSpace(),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                QuickActionChip(
                  icon: Icons.date_range_rounded,
                  label: 'تغيير الفترة',
                  onTap: () => AttendancePeriodDialog.show(context, controller),
                ),
                QuickActionChip(
                  icon: Icons.refresh_rounded,
                  label: 'تحديث',
                  onTap: controller.refreshHistory,
                ),
              ],
            ),
            14.verticalSpace(),
            AttendanceHistorySummaryStats(controller: controller),
          ],
        ),
      ),
    );
  }
}


