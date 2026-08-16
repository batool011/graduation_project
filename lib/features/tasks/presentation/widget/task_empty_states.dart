import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _TaskEmptyShell extends StatelessWidget {
  const _TaskEmptyShell({required this.icon, required this.action});

  final IconData icon;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColor.grey.withOpacity(0.14)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.07),
            blurRadius: 28,
            offset: const Offset(0, 16),
            spreadRadius: -18,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFEEF2FF), Color(0xFFE4EAFF)],
              ),
              border: Border.all(color: const Color(0xFF4F46E5).withOpacity(0.12)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4F46E5).withOpacity(0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                  spreadRadius: -12,
                ),
              ],
            ),
            child: Icon(icon, size: 40, color: const Color(0xFF4F46E5)),
          ),
          const SizedBox(height: 20),
          Text(
            AppString.noTasksAvailable.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            AppString.updateDataOrSendNew.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.blackLight,
                  height: 1.4,
                ),
          ),
          const SizedBox(height: 22),
          action,
        ],
      ),
    );
  }
}

class FilteredTasksEmptyState extends StatelessWidget {
  const FilteredTasksEmptyState({super.key, required this.onClearFilter});

  final VoidCallback onClearFilter;

  @override
  Widget build(BuildContext context) {
    return _TaskEmptyShell(
      icon: Icons.filter_alt_off_rounded,
      action: OutlinedButton.icon(
        onPressed: onClearFilter,
        icon: const Icon(Icons.clear_rounded, size: 18),
        label: Text(AppString.allTasks.tr),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF4F46E5),
          backgroundColor: const Color(0xFF4F46E5).withOpacity(0.04),
          side: BorderSide(color: const Color(0xFF4F46E5).withOpacity(0.6)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}

class EmptyTasksState extends StatelessWidget {
  const EmptyTasksState({super.key, required this.onRefresh});

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return _TaskEmptyShell(
      icon: Icons.task_alt_rounded,
      action: ElevatedButton.icon(
        onPressed: () => onRefresh(),
        icon: const Icon(Icons.refresh_rounded, size: 18),
        label: Text(AppString.refresh.tr),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4F46E5),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
