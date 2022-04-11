import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';

class PageData {
  static const accountTypes = <List<String>>[
    ["Individual seller", "Company"],
    ["Magánszemély", "Cég"],
    ["Persoană fizică", "Firmă"]
  ];

  static List<String> getAccountTypes(AppLanguage appLanguage) {
    return accountTypes[appLanguage.localeIndex];
  }

  static String getAccountType(AppLanguage appLanguage, int index) {
    if (index > 3 || index < 0) {
      return '';
    }

    return getAccountTypes(appLanguage)[index];
  }
}