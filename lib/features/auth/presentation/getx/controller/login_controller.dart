import 'package:career/core/router/routes_name.dart';
import 'package:career/core/widget/snak_bar_service.dart';
import 'package:career/core/network/token_storage.dart';
import 'package:career/features/auth/data/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController userName;
  late TextEditingController password;
  var isEyeOpen = false.obs;
  var isLoading = false.obs;

  final AuthRepository repo = AuthRepository();

  void toggleEye() {
    isEyeOpen.value = !isEyeOpen.value;
  }

  Future<void> login() async {
    final userNameValue = userName.text.trim();
    final passwordValue = password.text;

    if (userNameValue.isEmpty || passwordValue.isEmpty) {
      SnackbarService.error('يرجى إدخال البريد الإلكتروني وكلمة المرور');
      return;
    }

    isLoading.value = true;

    try {
      final result = await repo.login(
        data: {'username': userNameValue, 'password': passwordValue},
      );

      result.fold(
        (failure) {
          SnackbarService.error(failure.message);
        },
        (response) async {
          final token = response.data['data']['access_token']?.toString();
          print(token);
          if (token == null || token.isEmpty) {
            SnackbarService.error('لم يتم استلام التوكن من السيرفر');
            return;
          }

          await TokenStorage.saveToken(token);
          final responseName =
              response.data['data']?['name']?.toString().trim() ??
              response.data['data']?['user']?['name']?.toString().trim() ??
              '';
          await TokenStorage.saveUserName(
            responseName.isNotEmpty ? responseName : userNameValue,
          );
          SnackbarService.success('تم تسجيل الدخول بنجاح');
          Get.offAllNamed(RoutesName.home);
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    userName = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    userName.dispose();
    password.dispose();
    super.onClose();
  }
}
