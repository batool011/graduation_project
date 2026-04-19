import 'package:career/core/theme/style_manger.dart';
import 'package:flutter/material.dart';

import '../constant/class/app_color.dart';

// Light Theme
ThemeData getLightTheme(BuildContext context) => ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
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

    labelLarge: getBoldStyle(color: AppColor.lightWhite, fontSize: 20),
    labelMedium: getMediumStyle(color: AppColor.lightWhite, fontSize: 16),
    labelSmall: getRegularStyle(color: AppColor.lightWhite, fontSize: 14),
  ),
  scaffoldBackgroundColor: AppColor.lightWhite,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
    fillColor: AppColor.lightWhite,
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
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColor.primaryColor,
    onPrimary: AppColor.lightWhite,
    secondary: AppColor.lightWhite,
    onSecondary: AppColor.lightWhite,
    error: AppColor.errorColor,
    onError: AppColor.errorColor,
    surface: AppColor.lightWhite,
    onSurface: AppColor.primaryColor,
  ),
  unselectedWidgetColor: Colors.pink,
  primaryColor: AppColor.primaryColor,
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: AppColor.lightWhite,
    centerTitle: true,
    titleTextStyle: getBoldStyle(color: AppColor.primaryColor, fontSize: 22),
  ),
);

// Dark Theme
ThemeData getDarkTheme(BuildContext context) => ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  textTheme: TextTheme(
    displayLarge: getBoldStyle(color: AppColor.darkPrimaryColor, fontSize: 20),
    displayMedium: getMediumStyle(color: AppColor.darkPrimaryColor, fontSize: 16),
    displaySmall: getRegularStyle(color: AppColor.darkPrimaryColor, fontSize: 14),

    headlineLarge: getBoldStyle(color: AppColor.darkPrimaryColor, fontSize: 40),
    headlineMedium: getMediumStyle(color: AppColor.darkPrimaryColor, fontSize: 32),
    headlineSmall: getRegularStyle(color: AppColor.darkPrimaryColor, fontSize: 14),

    bodyLarge: getBoldStyle(color: AppColor.darkTextColor, fontSize: 20),
    bodyMedium: getMediumStyle(color: AppColor.darkTextColor, fontSize: 16),
    bodySmall: getRegularStyle(color: AppColor.darkTextColor, fontSize: 14),

    labelLarge: getBoldStyle(color: AppColor.darkTextColor, fontSize: 20),
    labelMedium: getMediumStyle(color: AppColor.darkTextColor, fontSize: 16),
    labelSmall: getRegularStyle(color: AppColor.darkTextColor, fontSize: 14),
  ),
  scaffoldBackgroundColor: AppColor.darkBackgroundColor,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
    fillColor: AppColor.darkSurfaceColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(color: AppColor.darkSurfaceColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(color: AppColor.darkSurfaceColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(color: AppColor.darkPrimaryColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(color: AppColor.errorColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(color: AppColor.errorColor),
    ),
    hintStyle: getRegularStyle(color: AppColor.darkTextSecondaryColor, fontSize: 12),
  ),
  dividerTheme: const DividerThemeData(color: AppColor.darkSurfaceColor),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColor.darkPrimaryColor,
    onPrimary: AppColor.darkBackgroundColor,
    secondary: AppColor.darkSurfaceColor,
    onSecondary: AppColor.darkTextColor,
    error: AppColor.errorColor,
    onError: AppColor.errorColor,
    surface: AppColor.darkSurfaceColor,
    onSurface: AppColor.darkTextColor,
  ),
  unselectedWidgetColor: Colors.grey,
  primaryColor: AppColor.darkPrimaryColor,
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: AppColor.darkSurfaceColor,
    centerTitle: true,
    titleTextStyle: getBoldStyle(color: AppColor.darkTextColor, fontSize: 22),
  ),
);

// Backward compatibility - default light theme
ThemeData getApplicationTheme(BuildContext context) => getLightTheme(context);
