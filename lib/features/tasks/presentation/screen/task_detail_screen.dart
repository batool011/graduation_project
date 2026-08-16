import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_string.dart';
import 'package:career/core/widget/custom_app_bar.dart';
import 'package:career/features/tasks/data/model/task_model.dart';
import 'package:career/features/tasks/presentation/widget/task_details_card.dart';
import 'package:career/features/tasks/presentation/widget/task_header_card.dart';
import 'package:career/features/tasks/presentation/widget/task_status_change_card.dart';
import 'package:career/features/tasks/presentation/widget/task_status_style.dart';
import 'package:career/features/tasks/presentation/widget/task_timeline_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskModel? task;
  final ValueChanged<String>? onStatusChanged;

  const TaskDetailsScreen({
    super.key,
    this.task,
    this.onStatusChanged,
  });

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  TaskModel? _task;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _task = widget.task ?? _getTaskFromArguments();
    _selectedStatus = _task?.status;
  }

  void _changeStatus(String status) {
    if (_selectedStatus == status) return;

    setState(() {
      _selectedStatus = status;
    });

    widget.onStatusChanged?.call(status);
  }

  @override
  Widget build(BuildContext context) {
    final taskData = _task;

    if (taskData == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF6F8FC),
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: CustomAppBar(text: AppString.task.tr),
        ),
        body: Center(
          child: Text(
            AppString.taskNotFound.tr,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      );
    }

    final statusStage = TaskStatusStyle.stageFromOptionValue(
      _selectedStatus,
      fallback: taskData.statusStage,
    );

    final statusLabel = TaskStatusStyle.labelForOptionValue(
      _selectedStatus,
      fallbackKey: taskData.statusTranslationKey,
    );

    final style = TaskStatusStyle.fromStage(statusStage, statusLabel);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.task.tr),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TaskHeaderCard(
              task: taskData,
              statusColor: style.color,
              statusText: style.label,
            ),
            const SizedBox(height: 16),
            TaskDetailsCard(
              task: taskData,
              statusColor: style.color,
              statusText: style.label,
            ),
            const SizedBox(height: 16),
            TaskStatusChangeCard(
              options: TaskStatusOption.all(),
              selectedStatus: _selectedStatus,
              activeColor: style.color,
              enabled: widget.onStatusChanged != null,
              onSelected: _changeStatus,
            ),
            const SizedBox(height: 16),
            TaskTimelineCard(task: taskData, statusColor: style.color),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  TaskModel? _getTaskFromArguments() {
    final arguments = Get.arguments;

    if (arguments is TaskModel) {
      return arguments;
    }

    if (arguments is Map && arguments['task'] is TaskModel) {
      return arguments['task'] as TaskModel;
    }

    return null;
  }
}
