import 'package:career/features/vacation/presentation/getx/controller/vacation_controller.dart';
import 'package:get/get.dart';

class VacationBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<VacationController>(() => VacationController());

  }
}
