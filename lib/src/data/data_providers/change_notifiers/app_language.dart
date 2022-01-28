import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale('en');

  Locale get appLocale => _appLocale;

  int get localeIndex {
    if (_appLocale == const Locale('hu')) {
      return 1;
    } else if (_appLocale == const Locale('ro')) {
      return 2;
    }
    return 0;
  }

  static Locale getLocaleByName(String? localeText) {
    try {
      if (localeText == null) {
        throw Exception();
      }

      return Locale(localeText);
    } catch (e) {
      return const Locale('en');
    }
  }

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = const Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code') ?? 'en');
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("hu")) {
      _appLocale = const Locale("hu");
      await prefs.setString('language_code', 'hu');
    } else if (type == const Locale("ro")) {
      _appLocale = const Locale("ro");
      await prefs.setString('language_code', 'ro');
    } else {
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
    }
    notifyListeners();
  }
}