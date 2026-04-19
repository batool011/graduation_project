import 'package:career/core/constant/class/app_color.dart';
import 'package:career/features/work_schedule/presentation/widget/work_schedule_head_cell.dart';
import 'package:flutter/material.dart';

class WorkScheduleTableHeader extends StatelessWidget {
  const WorkScheduleTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColor.lightGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: const Row(
        children: [
          WorkScheduleHeadCell(text: 'اليوم', flex: 2),
          WorkScheduleHeadCell(text: 'الدخول', flex: 1),
          WorkScheduleHeadCell(text: 'الخروج', flex: 1),
          WorkScheduleHeadCell(text: 'الحالة', flex: 1),
        ],
      ),
    );
  }
}
