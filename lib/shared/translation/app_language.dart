import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale('en');

  Locale get appLocal => _appLocale;

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