import 'package:career/core/constant/class/app_color.dart';
import 'package:career/features/work_schedule/data/model/work_day_model.dart';
import 'package:career/features/work_schedule/presentation/widget/work_schedule_table_header.dart';
import 'package:career/features/work_schedule/presentation/widget/work_schedule_table_row.dart';
import 'package:flutter/material.dart';

class WorkScheduleTable extends StatelessWidget {
  final List<WorkDayModel> rows;
  final Color Function(String status) statusBgColor;
  final Color Function(String status) statusTextColor;

  const WorkScheduleTable({
    super.key,
    required this.rows,
    required this.statusBgColor,
    required this.statusTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.darkGrey.withAlpha(70)),
      ),
      child: Column(
        children: [
          const WorkScheduleTableHeader(),
          const Divider(height: 1),
          ...rows.map(
            (row) => WorkScheduleTableRow(
              row: row,
              statusBgColor: statusBgColor,
              statusTextColor: statusTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
