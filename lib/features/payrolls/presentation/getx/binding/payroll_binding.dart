import 'package:career/features/payrolls/presentation/getx/controller/payroll_controller.dart';
import 'package:get/get.dart';

class PayrollBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayrollController>(() => PayrollController());
  }
}
