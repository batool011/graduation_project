import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _tokenKey = "token";
  static const String _deviceToken = 'deviceToken';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }


  static Future<void> saveDeviceToken(String deviceToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_deviceToken, deviceToken);
  }



  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> getDeviceToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_deviceToken);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> clearDeviceToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_deviceToken);
  }

}
