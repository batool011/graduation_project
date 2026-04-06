import 'package:career/features/tasks/presentation/getx/controller/tasks_controller.dart';
import 'package:get/get.dart';


class TasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TasksController());
  }
}
