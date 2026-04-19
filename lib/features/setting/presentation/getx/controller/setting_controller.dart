import 'package:career/core/network/token_storage.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/core/theme/theme_controller.dart';
import 'package:career/core/widget/snak_bar_service.dart';
import 'package:career/features/auth/data/repository/auth_repository.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final AuthRepository repo = AuthRepository();
  final ThemeController themeController = Get.find<ThemeController>();

  Future<void> performLogout() async {
    String message = 'تم تسجيل الخروج بنجاح';

    try {
      final result = await repo.logout().timeout(const Duration(seconds: 8));
      result.fold(
        (failure) {
          message = 'تم تسجيل الخروج محليًا';
        },
        (response) {
          final apiMessage =
              response.data is Map<String, dynamic>
                  ? (response.data['message']?.toString().trim() ?? '')
                  : '';
          if (apiMessage.isNotEmpty) {
            message = apiMessage;
          }
        },
      );
    } catch (_) {
      message = 'تم تسجيل الخروج محليًا';
    }

    await TokenStorage.clearToken();
    await TokenStorage.clearDeviceToken();
    SnackbarService.success(message);
    Get.offAllNamed(RoutesName.login);
  }
}
