import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_section_title.dart';
import 'task_status_style.dart';

class TaskStatusOption {
  const TaskStatusOption({
    required this.value,
    required this.label,
    required this.stage,
  });

  final String value;
  final String label;
  final int stage;

  static List<TaskStatusOption> all() => const [
        TaskStatusOption(value: 'In Queue', label: AppString.taskInQueue, stage: 0),
        TaskStatusOption(value: 'In Progress', label: AppString.taskInProgress, stage: 1),
        TaskStatusOption(value: 'Completed', label: AppString.taskCompleted, stage: 2),
      ];
}

class TaskStatusChangeCard extends StatelessWidget {
  const TaskStatusChangeCard({
    super.key,
    required this.options,
    required this.selectedStatus,
    required this.activeColor,
    required this.enabled,
    required this.onSelected,
  });

  final List<TaskStatusOption> options;
  final String? selectedStatus;
  final Color activeColor;
  final bool enabled;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: activeColor.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TaskSectionTitle(
            icon: Icons.tune_rounded,
            title: AppString.taskStatus.tr,
            color: activeColor,
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final selected = option.value == selectedStatus;
              final optionColor =
                  TaskStatusStyle.fromStage(option.stage, '').color;

              return ChoiceChip(
                selected: selected,
                showCheckmark: false,
                onSelected:
                    enabled && !selected ? (_) => onSelected(option.value) : null,
                label: Text(option.label.tr),
                labelStyle: TextStyle(
                  color: selected ? Colors.white : optionColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
                selectedColor: optionColor,
                backgroundColor: optionColor.withOpacity(0.08),
                side: BorderSide(color: optionColor.withOpacity(selected ? 0 : 0.25)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
              );
            }).toList(),
          ),
          if (!enabled)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                '-',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColor.blackLight,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
