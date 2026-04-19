import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:career/features/work_schedule/presentation/getx/controller/work_schedule_controller.dart';
import 'package:career/features/work_schedule/presentation/widget/work_schedule_header_card.dart';
import 'package:career/features/work_schedule/presentation/widget/work_schedule_stats_row.dart';
import 'package:career/features/work_schedule/presentation/widget/work_schedule_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkScheduleScreen extends GetView<WorkScheduleController> {
  const WorkScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: CustomAppBar(text: 'جدول الدوام'),
      ),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.symmetric(horizontal: 0.05.w(context), vertical: 0.02.h(context)),
          children: [
            WorkScheduleHeaderCard(
              weekRange: controller.weekRange,
              totalHours: controller.totalHours,
            ),
            14.verticalSpace(),
            WorkScheduleStatsRow(
              attendanceDays: controller.attendanceDays,
              lateCount: controller.lateCount,
              vacationDays: controller.vacationDays,
            ),
            14.verticalSpace(),
            WorkScheduleTable(
              rows: controller.rows,
              statusBgColor: controller.statusBgColor,
              statusTextColor: controller.statusTextColor,
            ),
            12.verticalSpace(),
          ],
        ),
      ),
    );
  }
}
