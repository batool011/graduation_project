import 'package:career/core/widget/snak_bar_service.dart';
import 'package:career/features/tasks/data/model/task_model.dart';
import 'package:career/features/tasks/data/repository/tasks_repository.dart';
import 'package:get/get.dart';

class TasksController extends GetxController {
  final TasksRepository _repo = TasksRepository();

  final isLoading = false.obs;
  final tasks = <TaskModel>[].obs;

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
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }
}
