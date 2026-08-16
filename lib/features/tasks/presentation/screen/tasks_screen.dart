import 'package:career/core/widget/custom_app_bar.dart';
import 'package:career/features/tasks/presentation/getx/controller/tasks_controller.dart';
import 'package:career/features/tasks/presentation/widget/all_tasks_header.dart';
import 'package:career/features/tasks/presentation/widget/custom_card_task.dart';
import 'package:career/features/tasks/presentation/widget/task_empty_states.dart';
import 'package:career/features/tasks/presentation/widget/tasks_top_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/class/app_string.dart';

class TasksScreen extends GetView<TasksController> {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.task.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
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
                    const SizedBox(height: 8),
                    TasksTopHeader(controller: controller),
                    const SizedBox(height: 24),
                    EmptyTasksState(onRefresh: controller.fetchTasks),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            }

            final visibleTasks = controller.filteredTasks;
            final latestTask = controller.latestTask;

            return RefreshIndicator(
              onRefresh: controller.fetchTasks,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  TasksTopHeader(controller: controller),
                  const SizedBox(height: 18),
                  if (latestTask != null) ...[
                    CustomTaskCard(
                      task: latestTask,
                      featured: true,
                      onStatusChanged: (status) => controller.updateTaskStatus(
                        task: latestTask,
                        status: status,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  AllTasksHeader(count: visibleTasks.length),
                  const SizedBox(height: 14),
                  if (visibleTasks.isEmpty)
                    FilteredTasksEmptyState(
                      onClearFilter: () => controller.setFilter(TaskFilter.all),
                    )
                  else
                    ...visibleTasks.skip(1).map(
                          (task) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CustomTaskCard(
                              task: task,
                              onStatusChanged: (status) => controller.updateTaskStatus(
                                task: task,
                                status: status,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
