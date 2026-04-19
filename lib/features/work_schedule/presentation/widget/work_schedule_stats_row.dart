import 'package:career/features/work_schedule/presentation/widget/work_schedule_stat_card.dart';
import 'package:flutter/material.dart';

class WorkScheduleStatsRow extends StatelessWidget {
  final String attendanceDays;
  final String lateCount;
  final String vacationDays;

  const WorkScheduleStatsRow({
    super.key,
    required this.attendanceDays,
    required this.lateCount,
    required this.vacationDays,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: WorkScheduleStatCard(
            label: 'أيام الحضور',
            value: attendanceDays,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: WorkScheduleStatCard(
            label: 'مرات التأخير',
            value: lateCount,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: WorkScheduleStatCard(
            label: 'أيام الإجازة',
            value: vacationDays,
          ),
        ),
      ],
    );
  }
}
