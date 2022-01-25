import 'package:flutter/material.dart';

enum AppThemeMode {
  light,
  dark
}

class CustomAppTheme {
  final Color loginGradientStart;
  final Color loginGradientEnd;
  final Color loginInputColor;
  final Color loginButtonsColor;
  final Color loginButtonText;
  final Color dropdownItemColor;
  final Color authErrorColor;
  final Color dotColor;
  final Color activeDotColor;
  final Color textFieldBackgroundColor;
  final Color textFieldHintColor;
  final List<Color> authPagesPrimaryColors;
  final Color NewListingTextField;
  final Color NewListingIcon;
  final Color filterActionButtonColor;
  final Color onFilterActionButtonColor;

  const CustomAppTheme({
    required this.loginGradientStart,
    required this.loginGradientEnd,
    required this.loginInputColor,
    required this.loginButtonsColor,
    required this.loginButtonText,
    required this.dropdownItemColor,
    required this.authErrorColor,
    required this.dotColor,
    required this.activeDotColor,
    required this.authPagesPrimaryColors,
    required this.textFieldBackgroundColor,
    required this.textFieldHintColor,
    required this.filterActionButtonColor,
    required this.onFilterActionButtonColor
    required this.textFieldHintColor,
    required this.NewListingTextField,
    required this.NewListingIcon
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
    loginGradientStart: const Color(0xFF0E7FC2),
    loginGradientEnd: const Color(0xFF015497),
    loginInputColor: const Color(0xFF12B3F2).withOpacity(0.5),
    loginButtonsColor: Colors.white,
    loginButtonText: const Color(0xFF12B3F2),
    dropdownItemColor: const Color(0xFF008eca),
    authErrorColor: const Color(0xFFFF80AB),
    dotColor: Colors.black,
    activeDotColor: const Color(0xFF12B3F2),
    authPagesPrimaryColors: [
      const Color(0xFF12B3F1).withOpacity(0.3),
      const Color(0xFF2ABBF3).withOpacity(0.3),
      const Color(0xFF41C2F5).withOpacity(0.3),
      const Color(0xFF71D1F7).withOpacity(0.3),
    ],
    textFieldBackgroundColor: const Color(0xffffffff).withOpacity(0.6),
    textFieldHintColor: const Color(0xff000000),
    NewListingTextField: const Color(0xff2c2c2c),
    NewListingIcon: const Color(0xff2c2c2c),
    textFieldHintColor: const Color(0xff000000),
    filterActionButtonColor: const Color(0xFF41C2F5),
    onFilterActionButtonColor: Colors.white
  );

  CustomAppTheme customDarkTheme = CustomAppTheme(
    loginGradientStart: const Color(0xFF1F1F1F),
    loginGradientEnd: const Color(0xFF1F1F1F),
    loginInputColor: const Color(0xFF2B2B2B),
    loginButtonsColor: const Color(0xFF2A2A2A),
    loginButtonText: Colors.white,
    dropdownItemColor: const Color(0xFF2B2B2B),
    authErrorColor: Colors.white,
    dotColor: Colors.white,
    activeDotColor: const Color(0xFF16BDFF),
    authPagesPrimaryColors: [
      const Color(0xFF1F1F1F).withOpacity(0.8),
      const Color(0xFF2B2B2B).withOpacity(0.7),
      const Color(0xFF2F2F2F).withOpacity(0.6),
      const Color(0xFF323232).withOpacity(1)
    ],
    textFieldBackgroundColor: const Color(0xff131313),
    textFieldHintColor: const Color(0xffffffff),
    NewListingTextField: const Color(0xffdedede),
    NewListingIcon: const Color(0xffdedede),
    textFieldHintColor: const Color(0xffffffff),
    filterActionButtonColor: const Color(0xFF2A2A2A),
    onFilterActionButtonColor: Colors.white
  );


  CustomAppTheme get customTheme {
    if (themeMode == AppThemeMode.dark) {
      return customDarkTheme;
    }
    return customLightTheme;
  }

  ThemeData get materialTheme {
    return themeData;
  }
}