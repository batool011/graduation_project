import 'package:career/features/tasks/presentation/getx/controller/tasks_controller.dart';
import 'package:career/features/tasks/presentation/widget/custom_card_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';

class TasksScreen extends GetView<TasksController> {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.task.tr),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.tasks.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.tasks.isEmpty) {
          return const Center(child: Text('لا توجد مهام حالياً'));
        }

        return RefreshIndicator(
          onRefresh: controller.fetchTasks,
          child: ListView.builder(
            itemCount: controller.tasks.length,
            itemBuilder: (context, index) {
              return CustomTaskCard(task: controller.tasks[index]);
            },
          ),
        );
      }),
    );
  }
}
