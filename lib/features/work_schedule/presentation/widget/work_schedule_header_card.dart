import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

class WorkScheduleHeaderCard extends StatelessWidget {
  final String weekRange;
  final String totalHours;

  const WorkScheduleHeaderCard({
    super.key,
    required this.weekRange,
    required this.totalHours,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.05.w(context), vertical: 0.022.h(context)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7382BF), Color(0xFF8E9BCE)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'أسبوع العمل الحالي',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          6.verticalSpace(),
          Text(
            weekRange,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColor.white.withAlpha(220),
            ),
          ),
          14.verticalSpace(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.white.withAlpha(35),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text(
              'إجمالي الساعات هذا الأسبوع: $totalHours',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColor.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
