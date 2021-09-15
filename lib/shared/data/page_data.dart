import 'package:my_instrument/shared/translation/app_language.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';

class PageData {
  static const AccountTypes = <List<String>>[
    ["Individual seller", "Company"],
    ["Magánszemély", "Cég"],
    ["Persoană fizică", "Firmă"]
  ];

  static List<String> getAccountTypes(AppLanguage appLanguage) {
    return AccountTypes[appLanguage.LocaleIndex];
  }

}