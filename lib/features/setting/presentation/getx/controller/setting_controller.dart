import 'package:career/core/network/token_storage.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/core/theme/theme_controller.dart';
import 'package:career/core/widget/snak_bar_service.dart';
import 'package:career/features/auth/data/repository/auth_repository.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final AuthRepository repo = AuthRepository();
  final ThemeController themeController = Get.find<ThemeController>();
  var isLoading = false.obs;

  Future<void> logout() async {
    isLoading.value = true;

    try {
      final result = await repo.logout();

      result.fold(
            (failure) {
          SnackbarService.error(failure.message);
        },
            (response) async {
          // حذف التوكن والبيانات من الجهاز
          await TokenStorage.clearToken();
          //await TokenStorage.clearUserName();

          SnackbarService.success('تم تسجيل الخروج بنجاح');

          // الرجوع لصفحة تسجيل الدخول
          Get.offAllNamed(RoutesName.login);
        },
      );
    } catch (e) {
      SnackbarService.error('حدث خطأ أثناء تسجيل الخروج');
    } finally {
      isLoading.value = false;
    }
  }
}
