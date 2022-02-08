import 'package:my_instrument/src/data/data_providers/services/shared_prefs.dart';

class ThemeStorageManager {
  static void saveData(String key, dynamic value) async {
    if (value is int) {
      SharedPrefs.instance.setInt(key, value);
    } else if (value is String) {
      SharedPrefs.instance.setString(key, value);
    } else if (value is bool) {
      SharedPrefs.instance.setBool(key, value);
    }
  }

  static dynamic readData(String key) {
    dynamic obj = SharedPrefs.instance.get(key);
    return obj;
  }

  static dynamic getThemeMode() {
    String obj = SharedPrefs.instance.getString('themeMode') ?? '';
    return obj == 'dark'
        ? 'dark'
        : 'light';
  }

  static Future<bool> deleteData(String key) async {
    return SharedPrefs.instance.remove(key);
  }
}