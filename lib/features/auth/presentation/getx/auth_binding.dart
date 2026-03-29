import 'package:career/features/auth/presentation/getx/controller/register_controller.dart';
import 'package:get/get.dart';
import 'controller/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<RegisterController>(() => RegisterController());

  }
}
