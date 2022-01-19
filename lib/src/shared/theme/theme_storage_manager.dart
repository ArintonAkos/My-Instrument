import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorageManager {
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<dynamic> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    String obj = prefs.getString('themeMode') ?? '';
    return obj == 'dark'
        ? 'dark'
        : 'light';
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}