import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> login(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username);
    await prefs.setBool("isLogin", true);
  }

  static Future<bool> checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }

  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("username");
    await prefs.setBool("isLogin", false);
  }
}