import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTasksHeader extends StatelessWidget {
  const AllTasksHeader({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppString.allTasks.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColor.black,
              ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor.primaryColor.withOpacity(0.10),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColor.primaryColor.withOpacity(0.14)),
          ),
          child: Text(
            '$count',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            height: 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: LinearGradient(
                colors: [
                  AppColor.grey.withOpacity(0.35),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
