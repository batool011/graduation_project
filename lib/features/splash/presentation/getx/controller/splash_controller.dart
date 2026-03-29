import 'package:get/get.dart';
import '../../../../../core/router/routes_name.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(RoutesName.onBoarding);
    });
  }
}
