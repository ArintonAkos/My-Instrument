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
  final Color DropdownItemColor;
  final Color AuthErrorColor;
  final List<Color> AuthPagesPrimaryColors;

  const CustomAppTheme({
    required this.LoginGradientStart,
    required this.LoginGradientEnd,
    required this.LoginInputColor,
    required this.LoginButtonsColor,
    required this.LoginButtonText,
    required this.DropdownItemColor,
    required this.AuthErrorColor,
    required this.AuthPagesPrimaryColors,
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
    LoginGradientStart: const Color(0xFF0E7FC2),
    LoginGradientEnd: const Color(0xFF015497),
    LoginInputColor: const Color(0xFF12B3F2).withOpacity(0.5),
    LoginButtonsColor: Colors.white,
    LoginButtonText: const Color(0xFF12B3F2),
    DropdownItemColor: const Color(0xFF008eca),
    AuthErrorColor: const Color(0xFFFF80AB),
    AuthPagesPrimaryColors: [
      const Color(0xFF12B3F1).withOpacity(0.3),
      const Color(0xFF2ABBF3).withOpacity(0.3),
      const Color(0xFF41C2F5).withOpacity(0.3),
      const Color(0xFF71D1F7).withOpacity(0.3),
    ]
  );

  CustomAppTheme customDarkTheme = CustomAppTheme(
    LoginGradientStart: const Color(0xFF1F1F1F),
    LoginGradientEnd: const Color(0xFF1F1F1F),
    LoginInputColor: const Color(0xFF2B2B2B),
    LoginButtonsColor: const Color(0xFF2A2A2A),
    LoginButtonText: Colors.white,
    DropdownItemColor: const Color(0xFF2B2B2B),
    AuthErrorColor: Colors.white,
    AuthPagesPrimaryColors: [
      const Color(0xFF1F1F1F).withOpacity(0.8),
      const Color(0xFF2B2B2B).withOpacity(0.7),
      const Color(0xFF2F2F2F).withOpacity(0.6),
      const Color(0xFF323232).withOpacity(1)
    ]
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