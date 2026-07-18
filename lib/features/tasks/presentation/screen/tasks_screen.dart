import 'package:career/features/tasks/presentation/getx/controller/tasks_controller.dart';
import 'package:career/features/tasks/presentation/widget/custom_card_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';

class TasksScreen extends GetView<TasksController> {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.task.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Obx(() {
            if (controller.isLoading.value && controller.tasks.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.tasks.isEmpty) {
              return RefreshIndicator(
                onRefresh: controller.fetchTasks,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 80),
                    _EmptyTasksState(onRefresh: controller.fetchTasks),
                  ],
                ),
              );
            }

            final latestTask = controller.latestTask!;

            return RefreshIndicator(
              onRefresh: controller.fetchTasks,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  CustomTaskCard(
                    task: latestTask,
                    featured: true,
                    onStatusChanged: (status) => controller.updateTaskStatus(
                      task: latestTask,
                      status: status,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Text(
                        AppString.allTasks.tr,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.black12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ...controller.tasks
                      .skip(1)
                      .map(
                        (task) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: CustomTaskCard(
                            task: task,
                            onStatusChanged: (status) => controller.updateTaskStatus(
                              task: task,
                              status: status,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _EmptyTasksState extends StatelessWidget {
  const _EmptyTasksState({required this.onRefresh});

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEAF0FF),
              ),
              child: const Icon(Icons.task_alt_rounded, color: Color(0xFF2563EB), size: 34),
            ),
            const SizedBox(height: 16),
            Text(
              AppString.noTasksAvailable.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              AppString.updateDataOrSendNew.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                  ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: () => onRefresh(),
              icon: const Icon(Icons.refresh_rounded),
              label: Text(AppString.refresh.tr),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
