import 'package:get/get.dart';
import '../../../../../core/network/token_storage.dart';
import '../../../../../core/router/routes_name.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateFromSplash();
  }

  Future<void> _navigateFromSplash() async {
    final token = await TokenStorage.getToken();
    final hasToken = token != null && token.trim().isNotEmpty;

    if (hasToken) {
      Get.offAllNamed(RoutesName.home);
      return;
    }

    await Future.delayed(const Duration(seconds: 3));

    Get.offNamed(RoutesName.onBoarding);
  }
}
