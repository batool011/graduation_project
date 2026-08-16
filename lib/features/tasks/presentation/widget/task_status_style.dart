import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Single source of truth for how a task status is colored/iconed/labeled.
/// Previously this exact mapping (colors, icons, label lookup) was
/// duplicated between `custom_card_task.dart` and `task_detail_screen.dart`
/// with slightly different helper names - any future status change had to
/// be edited in two places and could silently drift out of sync.
class TaskStatusStyle {
  final Color color;
  final IconData icon;
  final String label;

  const TaskStatusStyle({
    required this.color,
    required this.icon,
    required this.label,
  });

  /// Build from a [TaskModel.statusStage] (0 = queue, 1 = in progress,
  /// 2 = completed) plus the already-resolved display label.
  factory TaskStatusStyle.fromStage(int stage, String label) {
    return TaskStatusStyle(
      color: _colorForStage(stage),
      icon: _iconForStage(stage),
      label: label,
    );
  }

  static Color _colorForStage(int stage) {
    switch (stage) {
      case 0:
        return const Color(0xFFF59E0B);
      case 1:
        return const Color(0xFF2563EB);
      default:
        return const Color(0xFF16A34A);
    }
  }

  static IconData _iconForStage(int stage) {
    switch (stage) {
      case 0:
        return Icons.hourglass_top_rounded;
      case 1:
        return Icons.autorenew_rounded;
      default:
        return Icons.verified_rounded;
    }
  }

  /// Maps one of the fixed option values used by the status-change chips
  /// ("In Queue" / "In Progress" / "Completed") to its stage number.
  static int stageFromOptionValue(String? value, {required int fallback}) {
    switch (value) {
      case 'In Queue':
        return 0;
      case 'In Progress':
        return 1;
      case 'Completed':
        return 2;
      default:
        return fallback;
    }
  }

  /// Maps a `TaskModel.statusTranslationKey` to its display text.
  static String labelForTranslationKey(String key) {
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

  /// Resolves the label for the currently-selected status-change option
  /// (if any), falling back to the task's own translation key otherwise.
  static String labelForOptionValue(String? value, {required String fallbackKey}) {
    switch (value) {
      case 'In Queue':
        return AppString.taskInQueue.tr;
      case 'In Progress':
        return AppString.taskInProgress.tr;
      case 'Completed':
        return AppString.taskCompleted.tr;
      default:
        return labelForTranslationKey(fallbackKey);
    }
  }
}
