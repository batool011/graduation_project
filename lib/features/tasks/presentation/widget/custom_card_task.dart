import 'package:career/core/constant/class/app_color.dart';
import 'package:career/features/tasks/data/model/task_model.dart';
import 'package:career/features/tasks/presentation/screen/task_detail_screen.dart';
import 'package:career/features/tasks/presentation/widget/task_status_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTaskCard extends StatelessWidget {
  final TaskModel task;
  final ValueChanged<String>? onStatusChanged;
  final bool featured;
  final VoidCallback? onTap;

  const CustomTaskCard({
    super.key,
    required this.task,
    this.onStatusChanged,
    this.featured = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = TaskStatusStyle.fromStage(
      task.statusStage,
      TaskStatusStyle.labelForTranslationKey(task.statusTranslationKey),
    );
    final subtitle = _subtitle();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap ?? _openDetails,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: featured
                ? AppColor.primaryColor.withOpacity(0.03)
                : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: featured
                  ? AppColor.primaryColor.withOpacity(0.35)
                  : AppColor.grey.withOpacity(0.16),
              width: featured ? 1.3 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: style.color.withOpacity(featured ? 0.15 : 0.08),
                blurRadius: 18,
                offset: const Offset(0, 10),
                spreadRadius: -12,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: style.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: style.color.withOpacity(0.18)),
                ),
                child: Icon(style.icon, size: 22, color: style.color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (featured) ...[
                          Icon(
                            Icons.auto_awesome_rounded,
                            size: 14,
                            color: AppColor.primaryColor,
                          ),
                          const SizedBox(width: 4),
                        ],
                        Expanded(
                          child: Text(
                            task.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColor.black,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 12,
                          color: AppColor.blackLight,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColor.blackLight),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 110),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: style.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: style.color.withOpacity(0.16)),
                    ),
                    child: Text(
                      style.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: style.color,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 11,
                    color: AppColor.blackLight,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openDetails() {
    Get.to(
      () => TaskDetailsScreen(
        task: task,
        onStatusChanged: onStatusChanged,
      ),
    );
  }

  String _subtitle() {
    final List<String> parts = [];

    if (task.departmentName.trim().isNotEmpty) {
      parts.add(task.departmentName);
    }

    final date = task.endDateLabel.trim().isNotEmpty
        ? task.endDateLabel
        : task.startDateLabel;

    if (date.trim().isNotEmpty) {
      parts.add(date);
    }

    if (parts.isEmpty) return '-';

    return parts.join(' • ');
  }
}
