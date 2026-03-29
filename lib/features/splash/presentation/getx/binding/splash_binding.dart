import 'package:career/features/splash/presentation/getx/controller/splash_controller.dart';
import 'package:get/get.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
