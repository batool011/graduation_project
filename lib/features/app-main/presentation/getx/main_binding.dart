import 'package:career/features/employee_evaluation/presentation/getx/controller/employee_evaluation_controller.dart';
import 'package:career/features/courses/presentation/getx/controller/courses_controller.dart';
import 'package:get/get.dart';
import '../../../home/presentation/getx/controller/home_controller.dart';
import '../../../setting/presentation/getx/controller/setting_controller.dart';
class MainBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<EmployeeEvaluationController>(() => EmployeeEvaluationController());
    Get.lazyPut<SettingController>(() => SettingController());
    Get.lazyPut<CoursesController>(() => CoursesController());

  }
}
