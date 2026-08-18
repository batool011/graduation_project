import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/tasks/presentation/getx/controller/tasks_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksTopHeader extends StatelessWidget {
  const TasksTopHeader({super.key, required this.controller});

  final TasksController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColor.heroGradient(),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.30),
            blurRadius: 30,
            offset: const Offset(0, 16),
            spreadRadius: -18,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.16)),
                ),
                child: const Icon(
                  Icons.task_alt_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.task.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${controller.filteredTasks.length} ${AppString.allTasks.tr.toLowerCase()}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.82),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          TaskFilterBar(controller: controller),
        ],
      ),
    );
  }
}

class TaskFilterBar extends StatelessWidget {
  const TaskFilterBar({super.key, required this.controller});

  final TasksController controller;

  @override
  Widget build(BuildContext context) {
    final filters = [
      _FilterData(
        filter: TaskFilter.all,
        label: AppString.allTasks.tr,
        icon: Icons.grid_view_rounded,
      ),
      _FilterData(
        filter: TaskFilter.queue,
        label: AppString.taskInQueue.tr,
        icon: Icons.hourglass_top_rounded,
      ),
      _FilterData(
        filter: TaskFilter.progress,
        label: AppString.taskInProgress.tr,
        icon: Icons.autorenew_rounded,
      ),
      _FilterData(
        filter: TaskFilter.completed,
        label: AppString.taskCompleted.tr,
        icon: Icons.verified_rounded,
      ),
    ];

    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((item) {
            final selected = controller.selectedFilter.value == item.filter;

            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ChoiceChip(
                selected: selected,
                onSelected: (_) => controller.setFilter(item.filter),
                showCheckmark: false,
                avatar: Icon(
                  item.icon,
                  size: 16,
                  color: selected ? Colors.white :AppColor.primaryDark ,
                ),
                label: Text(item.label),
                labelStyle: TextStyle(
                  color: selected ? Colors.white :AppColor.primaryDark ,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
                selectedColor:AppColor.primaryColor,
                backgroundColor: Colors.white.withOpacity(0.14),
                side: BorderSide(
                  color: selected ? Colors.transparent : Colors.white.withOpacity(0.18),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _FilterData {
  const _FilterData({required this.filter, required this.label, required this.icon});

  final TaskFilter filter;
  final String label;
  final IconData icon;
}
