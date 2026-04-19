import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {
  // Light Mode Colors
  static const primaryColor = Color(0xFF7382bf);
  static const lightWhite = Color(0xFFFAFAFA);
  static const secondryColor = Color(0xFFfab20c);
  static const lightGrey = Color(0xFFF6F9F8);
  static const darkGrey = Color.fromARGB(255, 191, 188, 188);
  static const grey = Color(0xFFEDEAE4);
  static const lightBlackLight = Color(0xFF484848);
  static const lightScaffoldColor = Color(0xFFF7F9F8);
  static const lightBlack = Colors.black;
  static const errorColor = Colors.red;

  // Dark Mode Colors
  static const darkPrimaryColor = Color(0xFF5566AD);
  static const darkBackgroundColor = Color(0xFF121212);
  static const darkSurfaceColor = Color(0xFF1E1E1E);
  static const darkSecondaryColor = Color(0xFFfab20c);
  static const darkTextColor = Color(0xFFE0E0E0);
  static const darkTextSecondaryColor = Color(0xFFB0B0B0);

  static Color get white => Get.isDarkMode ? darkSurfaceColor : lightWhite;
  static Color get scaffoldColor =>
      Get.isDarkMode ? darkBackgroundColor : lightScaffoldColor;
  static Color get black => Get.isDarkMode ? darkTextColor : lightBlack;
  static Color get blackLight =>
      Get.isDarkMode ? darkTextSecondaryColor : lightBlackLight;
}