import 'package:career/features/complaints/presentation/getx/controller/complaints_controller.dart';
import 'package:get/get.dart';

class ComplaintsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ComplaintsController());
  }
}