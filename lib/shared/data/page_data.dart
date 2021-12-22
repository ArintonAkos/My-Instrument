import 'package:my_instrument/shared/translation/app_language.dart';

class PageData {
  static const accountTypes = <List<String>>[
    ["Individual seller", "Company"],
    ["Magánszemély", "Cég"],
    ["Persoană fizică", "Firmă"]
  ];

  static List<String> getAccountTypes(AppLanguage appLanguage) {
    return accountTypes[appLanguage.localeIndex];
  }

}