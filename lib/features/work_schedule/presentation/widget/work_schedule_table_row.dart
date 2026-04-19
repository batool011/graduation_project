import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/features/work_schedule/data/model/work_day_model.dart';
import 'package:flutter/material.dart';

class WorkScheduleTableRow extends StatelessWidget {
  final WorkDayModel row;
  final Color Function(String status) statusBgColor;
  final Color Function(String status) statusTextColor;

  const WorkScheduleTableRow({
    super.key,
    required this.row,
    required this.statusBgColor,
    required this.statusTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEF1F4))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.day,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColor.blackLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                2.verticalSpace(),
                Text(
                  row.date,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: AppColor.darkGrey),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              row.checkIn,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColor.blackLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.checkOut,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColor.blackLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor(row.status),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  row.status,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: statusTextColor(row.status),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
