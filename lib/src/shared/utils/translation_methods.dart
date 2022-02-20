import 'package:flutter/material.dart';

import '../translation/app_localizations.dart';

class TranslationMethods {
  static translateName(BuildContext context, String nameEn, String nameHu, String nameRo) {
    Locale? appLocale = AppLocalizations.of(context)?.locale;
    if (appLocale != null) {
      if (appLocale == const Locale("hu")) {
        return nameHu;
      } else if (appLocale == const Locale("ro")) {
        return nameRo;
      }
    }
    return nameEn;
  }
}