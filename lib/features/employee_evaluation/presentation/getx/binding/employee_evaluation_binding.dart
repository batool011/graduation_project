import 'package:career/features/employee_evaluation/presentation/getx/controller/employee_evaluation_controller.dart';
import 'package:get/get.dart';

class EmployeeEvaluationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeEvaluationController>(() => EmployeeEvaluationController());
  }
}