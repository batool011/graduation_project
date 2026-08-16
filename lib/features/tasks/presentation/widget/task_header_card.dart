import 'package:career/core/constant/class/app_color.dart';
import 'package:career/features/tasks/data/model/task_model.dart';
import 'package:flutter/material.dart';
import 'task_status_badge.dart';

class TaskHeaderCard extends StatelessWidget {
  const TaskHeaderCard({
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: statusColor.withOpacity(0.14)),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.10),
            blurRadius: 24,
            offset: const Offset(0, 14),
            spreadRadius: -18,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TaskStatusBadge(label: statusText, color: statusColor),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColor.grey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '#${task.id}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColor.blackLight,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            task.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            task.description.isEmpty ? '-' : task.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.blackLight,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}
