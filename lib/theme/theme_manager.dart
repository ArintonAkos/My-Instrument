import 'package:flutter/material.dart';
import 'package:my_instrument/theme/theme_storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    backgroundColor: const Color(0xFF212121),
    dividerColor: Colors.black12,
    colorScheme: ColorScheme
        .fromSwatch(primarySwatch: Colors.grey)
        .copyWith(
        secondary: Colors.white,
        brightness: Brightness.dark
      ),
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    backgroundColor: const Color(0xFFE5E5E5),
    dividerColor: Colors.white54,
    colorScheme: ColorScheme
        .fromSwatch(primarySwatch: Colors.grey)
        .copyWith(
        secondary: Colors.black,
        brightness: Brightness.light
    ),
  );

  late ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    ThemeStorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    ThemeStorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    ThemeStorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}