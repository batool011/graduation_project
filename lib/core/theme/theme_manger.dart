import 'package:career/core/theme/style_manger.dart';
import 'package:flutter/material.dart';

import '../constant/class/app_color.dart';

getApplicationTheme(BuildContext context) => ThemeData(
  textTheme: TextTheme(
    displayLarge: getBoldStyle(color: AppColor.primaryColor, fontSize: 20),
    displayMedium: getMediumStyle(color: AppColor.primaryColor, fontSize: 16),
    displaySmall: getRegularStyle(color: AppColor.primaryColor, fontSize: 14),

    headlineLarge: getBoldStyle(color: AppColor.primaryColor, fontSize: 40),
    headlineMedium: getMediumStyle(color: AppColor.primaryColor, fontSize: 32),
    headlineSmall: getRegularStyle(color: AppColor.primaryColor, fontSize: 14),

    bodyLarge: getBoldStyle(color: AppColor.black, fontSize: 20),
    bodyMedium: getMediumStyle(color: AppColor.black, fontSize: 16),
    bodySmall: getRegularStyle(color: AppColor.black, fontSize: 14),

    labelLarge: getBoldStyle(color: AppColor.white, fontSize: 20),
    labelMedium: getMediumStyle(color: AppColor.white, fontSize: 16),
    labelSmall: getRegularStyle(color: AppColor.white, fontSize: 14),
  ),
   scaffoldBackgroundColor: AppColor.white,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
    fillColor: AppColor.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(color: AppColor.primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(color: AppColor.errorColor),
    ),
    hintStyle: getRegularStyle(color: AppColor.darkGrey, fontSize: 12),
  ),
  dividerTheme: const DividerThemeData(color: AppColor.darkGrey),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColor.primaryColor,
    onPrimary: AppColor.white,
    secondary: AppColor.white,
    onSecondary: AppColor.white,
    error: AppColor.errorColor,
    onError: AppColor.errorColor,
    surface: AppColor.white,
    onSurface: AppColor.primaryColor,
  ),
  unselectedWidgetColor: Colors.pink,
  primaryColor: AppColor.primaryColor,
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: AppColor.white,
    centerTitle: true,
    titleTextStyle: getBoldStyle(color: AppColor.primaryColor, fontSize: 22),
  ),
);
