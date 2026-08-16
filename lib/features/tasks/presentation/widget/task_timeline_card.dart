import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/tasks/data/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_section_title.dart';

class TaskTimelineCard extends StatelessWidget {
  const TaskTimelineCard({super.key, required this.task, required this.statusColor});

  final TaskModel task;
  final Color statusColor;

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
            icon: Icons.timeline_rounded,
            title: AppString.taskTimeline.tr,
            color: statusColor,
          ),
          const SizedBox(height: 16),
          TaskTimelineItem(
            label: AppString.startDate.tr,
            value: task.startDateLabel.isNotEmpty ? task.startDateLabel : '-',
            icon: Icons.play_arrow_rounded,
            color: AppColor.primaryColor,
          ),
          const SizedBox(height: 14),
          TaskTimelineItem(
            label: AppString.endDate.tr,
            value: task.endDateLabel.isNotEmpty ? task.endDateLabel : '-',
            icon: Icons.flag_rounded,
            color: statusColor,
          ),
        ],
      ),
    );
  }
}

class TaskTimelineItem extends StatelessWidget {
  const TaskTimelineItem({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withOpacity(0.10),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.18)),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColor.blackLight,
                    ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColor.black,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
