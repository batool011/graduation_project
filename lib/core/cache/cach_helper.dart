import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveData(data, {required String key, required String value}) async {
    return await sharedPreferences!.setString(key, value);
  }

  String? getData({required String key}) {
    return sharedPreferences!.getString(key);
  }

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences!.remove(key);
  }

  bool containsKey(String key) {
    return sharedPreferences!.containsKey(key);
  }

  final String _cachedCode = "cachedCode";
  static const String _profileShiftKey = 'profileShift';

  String getCachedLanguage() {
    final code = sharedPreferences!.getString(_cachedCode);
    if (code != null) {
      return code;
    } else {
      return 'ar';
    }
  }

  Future<void> cachedLanguage(String code) async {
    await sharedPreferences!.setString(_cachedCode, code);
  }

  Future<bool> cacheProfileShift(Map<String, dynamic>? shift) async {
    if (shift == null) {
      return await removeData(key: _profileShiftKey);
    }

    return await sharedPreferences!.setString(_profileShiftKey, jsonEncode(shift));
  }

  Map<String, dynamic>? getCachedProfileShift() {
    final cachedShift = sharedPreferences!.getString(_profileShiftKey);
    if (cachedShift == null || cachedShift.trim().isEmpty) {
      return null;
    }

    final decoded = jsonDecode(cachedShift);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    if (decoded is Map) {
      return decoded.cast<String, dynamic>();
    }

    return null;
  }
}
