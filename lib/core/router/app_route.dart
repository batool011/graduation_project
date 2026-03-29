import 'package:career/core/router/routes_name.dart';
import 'package:career/features/auth/presentation/getx/auth_binding.dart';
import 'package:career/features/auth/presentation/screen/create_new_account_screen.dart';
import 'package:career/features/auth/presentation/screen/log_in_screen.dart';
import 'package:career/features/auth/presentation/screen/register_screen.dart';
import 'package:career/features/auth/presentation/screen/verification_screen.dart';
import 'package:career/features/detail-job/presentation/screen/detail_job_screen.dart';
import 'package:career/features/on%20boarding/presentation/getx/binding/onboarding_binding.dart';
import 'package:career/features/on%20boarding/presentation/screen/on_boarding_screen.dart';
import 'package:career/features/setting/presentation/screen/my_job_screen.dart';
import 'package:career/features/setting/presentation/screen/setting_screen.dart';
import 'package:career/features/splash/presentation/screen/splash_screen.dart';
import 'package:get/get.dart';
import '../../features/app-main/presentation/getx/main_binding.dart';
import '../../features/app-main/presentation/screens/main_screen.dart';
import '../../features/detail-job/presentation/getx/binding/detail_job_binding.dart';
import '../../features/splash/presentation/getx/binding/splash_binding.dart';

class AppRoute {
  static final routes = [
    GetPage(
      name: RoutesName.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RoutesName.onBoarding,
      page: () => const OnBoardingScreen(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: RoutesName.login,
      page: () => const LogInScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RoutesName.createNewAccount,
      page: () => const CreateNewAccountScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RoutesName.verify,
      page: () => const VerificationScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RoutesName.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RoutesName.home,
      page: () =>  MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: RoutesName.detailJob,
      page: () =>  DetailJobScreen(),
      binding: DetailJobBinding(),
    ),
    GetPage(
      name: RoutesName.setting,
      page: () =>  SettingScreen(),
      binding: DetailJobBinding(),
    ),
    GetPage(
      name: RoutesName.myJob,
      page: () =>  MyJobScreen(),
      binding: DetailJobBinding(),
    ),

  ];
}
