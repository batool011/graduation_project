import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

import '../../data/models/attendance_history_model.dart';
import 'attendance_item.dart';

class AttendanceList extends StatelessWidget {
  const AttendanceList({
    super.key,
    required this.items,
    required this.onRefresh,
  });

  final List<AttendanceHistory> items;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.18),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 56,
                    color: AppColor.primaryColor.withOpacity(0.45),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'لا توجد سجلات حضور لهذا الشهر',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'اسحب للأسفل للتحديث أو جرّب شهرًا آخر.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColor.blackLight),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => 12.verticalSpace(),
        itemBuilder: (context, index) {
          return AttendanceItem(item: items[index]);
        },
      ),
    );
  }
}
