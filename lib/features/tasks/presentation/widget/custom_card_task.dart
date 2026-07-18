import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/tasks/data/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTaskCard extends StatelessWidget {
  final TaskModel task;
  final ValueChanged<String>? onStatusChanged;
  final bool featured;

  const CustomTaskCard({
    super.key,
    required this.task,
    this.onStatusChanged,
    this.featured = false,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(task.statusStage);
    final statusText = _statusText(task.statusTranslationKey);
    final formattedCreatedAt = task.createdAtLabel.isNotEmpty ? task.createdAtLabel : task.startDateLabel;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.01.h(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            featured ? AppColor.primaryColor.withOpacity(0.06) : AppColor.primaryColor.withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: featured ? AppColor.primaryColor.withOpacity(0.18) : AppColor.grey.withOpacity(0.35),
          width: featured ? 1.4 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned(
              top: -28,
              right: -24,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: statusColor.withOpacity(0.12),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0.04.h(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (featured)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            AppString.latestTask.tr,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                      const Spacer(),
                      _StatusBadge(
                        label: statusText,
                        color: statusColor,
                      ),
                    ],
                  ),
                  14.verticalSpace(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              AppColor.primaryColor,
                              AppColor.primaryColor.withOpacity(0.75),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(
                          Icons.task_alt_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      SizedBox(width: 0.03.w(context)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppColor.black,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              task.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColor.blackLight,
                                    height: 1.4,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace(),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _MetaChip(
                        icon: Icons.person_outline_rounded,
                        label: AppString.assignedBy.tr,
                        value: _firstNonEmpty([
                          task.assignedBy,
                          task.assignedByUsername,
                        ]),
                        color: AppColor.primaryColor,
                      ),
                      _MetaChip(
                        icon: Icons.badge_outlined,
                        label: AppString.employee.tr,
                        value: _firstNonEmpty([
                          task.employeeName,
                          task.employeeId.toString(),
                        ]),
                        color: Colors.teal,
                      ),
                      _MetaChip(
                        icon: Icons.apartment_outlined,
                        label: AppString.department.tr,
                        value: task.departmentName.isNotEmpty ? task.departmentName : '-',
                        color: Colors.indigo,
                      ),
                    ],
                  ),
                  16.verticalSpace(),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColor.lightGrey.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.taskTimeline.tr,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColor.black,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _TimelinePoint(
                              label: AppString.startDate.tr,
                              value: task.startDateLabel,
                              color: AppColor.primaryColor,
                              icon: Icons.play_arrow_rounded,
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                height: 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColor.primaryColor.withOpacity(0.2),
                                      statusColor.withOpacity(0.65),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            _TimelinePoint(
                              label: AppString.endDate.tr,
                              value: task.endDateLabel,
                              color: statusColor,
                              icon: Icons.flag_rounded,
                              alignEnd: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${AppString.task.tr} #${task.id} • $formattedCreatedAt',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColor.blackLight,
                              ),
                        ),
                      ],
                    ),
                  ),
                  16.verticalSpace(),
                  Row(
                    children: [
                      Text(
                        AppString.taskStatus.tr,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColor.blackLight,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        statusText,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _statusOptions().map((option) {
                      final selected = option.value == task.status;
                      final optionColor = _statusColor(option.stage);

                      return ChoiceChip(
                        selected: selected,
                        onSelected: onStatusChanged == null || selected
                            ? null
                            : (_) => onStatusChanged!(option.value),
                        label: Text(option.label.tr),
                        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: selected ? Colors.white : optionColor,
                              fontWeight: FontWeight.w700,
                            ),
                        selectedColor: optionColor,
                        backgroundColor: optionColor.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                          side: BorderSide(color: optionColor.withOpacity(0.2)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(int status) {
    switch (status) {
      case 0:
        return const Color(0xFFF59E0B);
      case 1:
        return const Color(0xFF2563EB);
      default:
        return const Color(0xFF16A34A);
    }
  }

  String _firstNonEmpty(List<String> values) {
    for (final value in values) {
      if (value.trim().isNotEmpty && value.trim() != '-') {
        return value;
      }
    }
    return '-';
  }

  String _statusText(String key) {
    switch (key) {
      case 'taskCompleted':
        return AppString.taskCompleted.tr;
      case 'taskInProgress':
        return AppString.taskInProgress.tr;
      case 'taskInQueue':
        return AppString.taskInQueue.tr;
      default:
        return AppString.taskUnknown.tr;
    }
  }

  List<_TaskStatusOption> _statusOptions() {
    return const [
      _TaskStatusOption(value: 'In Queue', label: AppString.taskInQueue, stage: 0),
      _TaskStatusOption(value: 'In Progress', label: AppString.taskInProgress, stage: 1),
      _TaskStatusOption(value: 'Completed', label: AppString.taskCompleted, stage: 2),
    ];
  }
}

class _TaskStatusOption {
  const _TaskStatusOption({
    required this.value,
    required this.label,
    required this.stage,
  });

  final String value;
  final String label;
  final int stage;
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 140),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColor.blackLight,
                      ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelinePoint extends StatelessWidget {
  const _TimelinePoint({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    this.alignEnd = false,
  });

  final String label;
  final String value;
  final Color color;
  final IconData icon;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
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
                fontWeight: FontWeight.w700,
                color: AppColor.black,
              ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

