import 'package:career/core/router/app_route.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/features/saving_money/pressentations/binding/savings_binding.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslation(),
      locale: const Locale('ar', 'AR'),
      fallbackLocale: const Locale('ar', 'AR'),
      theme: getApplicationTheme(context),
      initialRoute: RoutesName.savingCards,
      initialBinding: SavingsBinding(),
      getPages: AppRoute.routes,

    );
  }
}


