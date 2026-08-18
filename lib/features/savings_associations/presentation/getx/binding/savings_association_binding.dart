import 'package:get/get.dart';
import '../controller/savings_association_controller.dart';

class SavingsAssociationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavingsAssociationController>(() => SavingsAssociationController());
  }
}
