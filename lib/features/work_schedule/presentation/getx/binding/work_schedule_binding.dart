import 'package:career/features/work_schedule/presentation/getx/controller/work_schedule_controller.dart';
import 'package:get/get.dart';

class WorkScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkScheduleController>(() => WorkScheduleController());
  }
}
