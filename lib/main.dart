import'package:career/core/router/app_route.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/core/theme/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/localization/app_translation.dart';
import 'core/notification/push_notification_services.dart';
import 'core/theme/theme_manger.dart';
import 'features/splash/presentation/getx/binding/splash_binding.dart';
import 'firebase_options.dart';


 Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppTranslation.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingService().initNotificationsSettings();
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppTranslation(),
        locale: const Locale('ar', 'AR'),
        fallbackLocale: const Locale('ar', 'AR'),
        themeMode: themeController.themeMode.value,
        theme: getLightTheme(context),
        darkTheme: getDarkTheme(context),
        initialRoute: RoutesName.splash,
        initialBinding: SplashBinding(),
        getPages: AppRoute.routes,
      );
    });
  }
}


