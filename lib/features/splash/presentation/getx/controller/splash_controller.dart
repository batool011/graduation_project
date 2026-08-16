import 'package:get/get.dart';
import '../../../../../core/network/token_storage.dart';
import '../../../../auth/data/repository/auth_repository.dart';
import '../../../../../core/router/routes_name.dart';

class SplashController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  @override
  void onInit() {
    super.onInit();
    _navigateFromSplash();
  }

  Future<void> _navigateFromSplash() async {
    final token = await TokenStorage.getToken();
    final hasToken = token != null && token.trim().isNotEmpty;

    if (hasToken) {
      final refreshResult = await _authRepository.refreshToken();

      await refreshResult.fold(
        (failure) async {
          if (failure.statusCode == 401 || failure.statusCode == 403) {
            await TokenStorage.clearToken();
            Get.offAllNamed(RoutesName.login);
            return;
          }

          Get.offAllNamed(RoutesName.home);
        },
        (response) async {
          final refreshedToken =
              response.data['data']?['access_token']?.toString();
          if (refreshedToken != null && refreshedToken.trim().isNotEmpty) {
            await TokenStorage.saveToken(refreshedToken.trim());
          }

          Get.offAllNamed(RoutesName.home);
        },
      );

      return;
    }

    await Future.delayed(const Duration(seconds: 3));

    Get.offNamed(RoutesName.onBoarding);
  }
}
