import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/tasks/data/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_info_row.dart';
import 'task_section_title.dart';

class TaskDetailsCard extends StatelessWidget {
  const TaskDetailsCard({
    super.key,
    required this.task,
    required this.statusColor,
    required this.statusText,
  });

  final TaskModel task;
  final Color statusColor;
  final String statusText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColor.grey.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TaskSectionTitle(
            icon: Icons.info_outline_rounded,
            title: AppString.task.tr,
            color: AppColor.primaryColor,
          ),
          const SizedBox(height: 8),
          TaskInfoRow(
            label: AppString.taskStatus.tr,
            value: statusText,
            valueColor: statusColor,
          ),
          TaskInfoRow(
            label: AppString.assignedBy.tr,
            value: _firstNonEmpty([task.assignedBy, task.assignedByUsername]),
          ),
          TaskInfoRow(
            label: AppString.employee.tr,
            value: _firstNonEmpty([task.employeeName, task.employeeId.toString()]),
          ),
          TaskInfoRow(
            label: AppString.department.tr,
            value: task.departmentName.isNotEmpty ? task.departmentName : '-',
          ),
          TaskInfoRow(
            label: AppString.startDate.tr,
            value: task.startDateLabel.isNotEmpty ? task.startDateLabel : '-',
          ),
          TaskInfoRow(
            label: AppString.endDate.tr,
            value: task.endDateLabel.isNotEmpty ? task.endDateLabel : '-',
            isLast: true,
          ),
        ],
      ),
    );
  }

  String _firstNonEmpty(List<String> values) {
    for (final value in values) {
      final trimmed = value.trim();
      if (trimmed.isNotEmpty && trimmed != '-' && trimmed.toLowerCase() != 'null') {
        return value;
      }
    }
    return '-';
  }
}
