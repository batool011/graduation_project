import 'package:career/features/salary_policies/presentation/getx/controller/salary_policies_controller.dart';
import 'package:get/get.dart';

class SalaryPoliciesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalaryPoliciesController>(() => SalaryPoliciesController());
  }
}
