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

    labelLarge: getBoldStyle(color: AppColor.secondryColor, fontSize: 20),
    labelMedium: getMediumStyle(color: AppColor.secondryColor, fontSize: 16),
    labelSmall: getRegularStyle(color: AppColor.secondryColor, fontSize: 14),
  ),
   scaffoldBackgroundColor: AppColor.secondryColor,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
    fillColor: AppColor.secondryColor,
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
    onPrimary: AppColor.secondryColor,
    secondary: AppColor.secondryColor,
    onSecondary: AppColor.secondryColor,
    error: AppColor.errorColor,
    onError: AppColor.errorColor,
    surface: AppColor.secondryColor,
    onSurface: AppColor.primaryColor,
  ),
  unselectedWidgetColor: Colors.pink,
  primaryColor: AppColor.primaryColor,
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: AppColor.secondryColor,
    centerTitle: true,
    titleTextStyle: getBoldStyle(color: AppColor.primaryColor, fontSize: 22),
  ),
);
