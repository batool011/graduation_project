import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_container_icon.dart';
import 'package:career/features/tasks/data/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomTaskCard extends StatelessWidget {
  final TaskModel task;

  const CustomTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final statusIndex = _statusIndex(task.status);

    return Container(
      margin: EdgeInsets.all(0.01.h(context)),
      padding: EdgeInsets.all(0.03.h(context)),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.darkGrey,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            task.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          8.verticalSpace(),
          Text(
            task.description,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: AppColor.blackLight),
          ),
          12.verticalSpace(),
          Column(
            children: [
              CustomContainerIcon(
                title: AppString.assignedBy.tr,
                value: task.assignedBy,
                icon: Icons.person,
                color: AppColor.primaryColor,
              ),
              10.verticalSpace(),
              CustomContainerIcon(
                title: AppString.startDate.tr,
                value: task.startDate,
                icon: Icons.calendar_month_sharp,
                color: AppColor.primaryColor,
              ),
              10.verticalSpace(),
              CustomContainerIcon(
                title: AppString.endDate.tr,
                value: task.endDate,
                icon: Icons.calendar_month_sharp,
                color: AppColor.primaryColor,
              ),
            ],
          ),
          20.verticalSpace(),
          Row(
            children: [
              _circle(0, statusIndex),
              _line(statusIndex >= 1),
              _circle(1, statusIndex),
              _line(statusIndex >= 2),
              _circle(2, statusIndex),
            ],
          ),
          16.verticalSpace(),
          Text(
            _statusText(statusIndex),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _statusColor(statusIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(int index, int current) {
    final active = index <= current;

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: active ? AppColor.primaryColor : AppColor.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _line(bool active) {
    return Expanded(
      child: Container(
        height: 7,
        color: active ? AppColor.primaryColor : AppColor.grey,
      ),
    );
  }

  int _statusIndex(String status) {
    final normalized = status.toLowerCase().trim();

    if (normalized.contains('complete') || normalized.contains('done')) {
      return 2;
    }

    if (normalized.contains('progress') || normalized.contains('process')) {
      return 1;
    }

    return 0;
  }

  String _statusText(int status) {
    switch (status) {
      case 0:
        return 'لم تبدأ';
      case 1:
        return 'قيد التقدم';
      default:
        return 'مكتملة';
    }
  }

  Color _statusColor(int status) {
    switch (status) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.orange;
      default:
        return Colors.green;
    }
  }
}
