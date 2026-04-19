import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const String _themeKey = 'appTheme';
  
  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  
  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }
  
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString(_themeKey) ?? 'light';
    themeMode.value = themeName == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }
  
  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = themeMode.value == ThemeMode.dark;
    themeMode.value = isDark ? ThemeMode.light : ThemeMode.dark;
    await prefs.setString(_themeKey, isDark ? 'light' : 'dark');
  }
  
  bool get isDarkMode => themeMode.value == ThemeMode.dark;
}
