import 'package:get/get.dart';
import '../../../home/presentation/getx/controller/home_controller.dart';
class MainBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<HomeController>(() => HomeController());

  }
}
