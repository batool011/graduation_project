import 'package:career/core/widget/snak_bar_service.dart';
import 'package:career/features/tasks/data/model/task_model.dart';
import 'package:career/features/tasks/data/repository/tasks_repository.dart';
import 'package:get/get.dart';

class TasksController extends GetxController {
  final TasksRepository _repo = TasksRepository();

  final isLoading = false.obs;
  final tasks = <TaskModel>[].obs;

  TaskModel? get latestTask => tasks.isEmpty ? null : tasks.first;

  Future<void> refreshTasksSilently() async {
    final result = await _repo.getTasks();
    result.fold(
      (failure) {
        SnackbarService.error(failure.message);
      },
      (tasksList) {
        tasks.assignAll(tasksList);
        _sortTasks();
      },
    );
  }

  void _sortTasks() {
    tasks.sort((left, right) => right.sortDate.compareTo(left.sortDate));
  }

  Future<void> fetchTasks() async {
    isLoading.value = true;

    try {
      final result = await _repo.getTasks();

      result.fold(
        (failure) {
          SnackbarService.error(failure.message);
        },
        (tasksList) {
          tasks.assignAll(tasksList);
          _sortTasks();
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTaskStatus({
    required TaskModel task,
    required String status,
  }) async {
    final previousTask = task;

    final index = tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) {
      return;
    }

    tasks[index] = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      employeeId: task.employeeId,
      status: status,
      startDate: task.startDate,
      endDate: task.endDate,
      createdAt: task.createdAt,
      updatedAt: DateTime.now(),
      assignedBy: task.assignedBy,
      employeeName: task.employeeName,
      departmentName: task.departmentName,
      assignedByUsername: task.assignedByUsername,
    );

    _sortTasks();
    tasks.refresh();

    final result = await _repo.updateTaskStatus(taskId: task.id, status: status);
    result.fold(
      (failure) {
        final rollbackIndex = tasks.indexWhere((item) => item.id == previousTask.id);
        if (rollbackIndex != -1) {
          tasks[rollbackIndex] = previousTask;
        }
        _sortTasks();
        tasks.refresh();
        SnackbarService.error(failure.message);
      },
      (_) {
        _sortTasks();
        tasks.refresh();
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }
}
