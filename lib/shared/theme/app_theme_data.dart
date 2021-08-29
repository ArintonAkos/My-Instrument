import 'package:flutter/material.dart';

enum AppThemeMode {
  Light,
  Dark
}

class CustomAppTheme {
  final Color LoginGradientStart;
  final Color LoginGradientEnd;
  final Color LoginInputColor;
  final Color LoginButtonsColor;
  final Color LoginButtonText;

  const CustomAppTheme({
    required this.LoginGradientStart,
    required this.LoginGradientEnd,
    required this.LoginInputColor,
    required this.LoginButtonsColor,
    required this.LoginButtonText
  });
}

class AppThemeData {
  final ThemeData themeData;
  AppThemeMode themeMode;

  AppThemeData({
    required this.themeData,
    required this.themeMode
  });

  CustomAppTheme customLightTheme = CustomAppTheme(
    LoginGradientStart: const Color(0xFF12B3F2),
    LoginGradientEnd: const Color(0xFF015497),
    LoginInputColor: const Color(0xFF12B3F2).withOpacity(0.5),
    LoginButtonsColor: Colors.white,
    LoginButtonText: const Color(0xFF12B3F2),
  );

  CustomAppTheme customDarkTheme = CustomAppTheme(
    LoginGradientStart: const Color(0xFF1F1F1F),
    LoginGradientEnd: const Color(0xFF1F1F1F),
    LoginInputColor: const Color(0xFF2B2B2B),
    LoginButtonsColor: const Color(0xFF2A2A2A),
    LoginButtonText: Colors.white,
  );


  CustomAppTheme get customTheme {
    if (themeMode == AppThemeMode.Dark) {
      return customDarkTheme;
    }
    return customLightTheme;
  }

  ThemeData get materialTheme {
    return this.themeData;
  }
}