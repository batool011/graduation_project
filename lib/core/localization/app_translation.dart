import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTranslation extends Translations {
  static Map<String, String> en = {};
  static Map<String, String> ar = {};

  static Future<void> init() async {
    en = await loadJson("assets/lang/en.json");
    ar = await loadJson("assets/lang/ar.json");
  }

  static Future<Map<String, String>> loadJson(String path) async {
    String data = await rootBundle.loadString(path);
    return Map<String, String>.from(json.decode(data));
  }

  @override
  Map<String, Map<String, String>> get keys => {
    "en_US": en,
    "ar_AR": ar,
  };
}
