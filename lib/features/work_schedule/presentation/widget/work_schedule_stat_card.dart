import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

class WorkScheduleStatCard extends StatelessWidget {
  final String label;
  final String value;

  const WorkScheduleStatCard({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.darkGrey.withAlpha(80)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          3.verticalSpace(),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColor.blackLight,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
