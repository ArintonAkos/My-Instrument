import 'package:flutter/material.dart';
import 'package:my_instrument/src/shared/theme/app_theme_data.dart';
import 'package:my_instrument/src/shared/theme/theme_storage_manager.dart';
import '../../../shared/theme/app_theme_data.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = AppThemeData(
    themeMode: AppThemeMode.dark,
    themeData: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFF161616),
      backgroundColor: const Color(0xFF161616),
      dividerColor: const Color(0xFF121212),
      cardColor: const Color(0xFF303030),
      errorColor: const Color(0xFFB00020),
      colorScheme: ColorScheme
        .fromSwatch(primarySwatch: Colors.grey)
        .copyWith(
          primary: const Color(0xFF0096E1),
          primaryVariant: const Color(0xFF015497),
          // secondary: const Color(0xFF02E1EE),
          // secondaryVariant: const Color(0xFF01AEC1),
          surface: const Color(0xFF1E1E1E),
          onPrimary: const Color(0xFFFFFFFF),
          onSecondary: const Color(0xFFFFFFFF),
          onBackground: const Color(0xFFFFFFFF),
          onSurface: const Color(0xFFFFFFFF),
          onError: const Color(0xFFFFFFFF),
          brightness: Brightness.dark
        ),
    )
  );

  final lightTheme = AppThemeData(
    themeMode: AppThemeMode.light,
    themeData: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFFEFEFEF),
      backgroundColor: const Color(0xFFEFEFEF),
      dividerColor: Colors.grey,
      cardColor: const Color(0xFFFFFFFF),
      errorColor: const Color(0xFFB00020),
      colorScheme: ColorScheme
        .fromSwatch(primarySwatch: Colors.blue)
        .copyWith(
          primary: const Color(0xFF12B3F2),
          primaryVariant: const Color(0xFF015497),
          // secondary: const Color(0xFF02E1EE),
          // secondaryVariant: const Color(0xFF01AEC1),
          surface: const Color(0xFFFFFFFF),
          error: const Color(0xFFB00020),
          onPrimary: const Color(0xFFFFFFFF),
          onSecondary: const Color(0xFFFFFFFF),
          onBackground: const Color(0xFFFFFFFF),
          onSurface: const Color(0xFF000000),
          onError: const Color(0xFFFFFFFF),
          brightness: Brightness.light
        ),
    )
  );

  String _themeName = '';
  String getThemeName() => _themeName;

  AppThemeData? _themeData;
  AppThemeData? getTheme() => _themeData;

  bool get isDarkMode => _themeName == 'dark';

  ThemeNotifier() {
    String? themeMode = ThemeStorageManager.readData('themeMode');
    themeMode ??= 'light';

    if (themeMode == 'light') {
      _themeData = lightTheme;
    } else {
      _themeData = darkTheme;
    }
    _themeName = themeMode;
    notifyListeners();
  }

  void setDarkMode() {
    _themeData = darkTheme;
    _themeName = 'dark';
    ThemeStorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() {
    _themeData = lightTheme;
    _themeName = 'light';
    ThemeStorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}