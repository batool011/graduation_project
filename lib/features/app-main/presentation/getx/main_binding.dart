import 'package:get/get.dart';
import '../../../home/presentation/getx/controller/home_controller.dart';
import '../../../saving_money/presentation/controller/savings_controller.dart';
class MainBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SavingsController>(() => SavingsController());

  }
}
