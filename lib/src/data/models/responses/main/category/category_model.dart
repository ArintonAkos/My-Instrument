import 'package:flutter/cupertino.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/src/shared/utils/list_parser.dart';


class CategoryModel {
  Map<String, dynamic>? json;
  CategoryModel({
    required this.json
  }) {
    id = json?['id'] ?? -1;
    nameEn = json?['nameEn'] ?? '';
    nameHu = json?['nameHu'] ?? '';
    nameRo = json?['nameRo'] ?? '';
    imagePath = json?['imagePath'];
    imageHash = json?['imageHash'];
    children = ListParser.parse<CategoryModel>(json?['children'], parseCategoryModel);
  }

  late final int id;
  late final String nameEn;
  late final String nameHu;
  late final String nameRo;
  late final String? imagePath;
  late final String? imageHash;
  late final List<CategoryModel> children;

  String getCategoryName(BuildContext context) {
    Locale? appLocale = AppLocalizations.of(context)?.locale;
    if (appLocale != null) {
      if (appLocale == const Locale("hu")) {
        return nameHu;
      } else if (appLocale == const Locale("ro")) {
        return nameRo;
      } else {
        return nameEn;
      }
    }
    return "";
  }

  CategoryModel? parseCategoryModel(Map<String, dynamic> json) {
    if (json['id'] != null) {
      return CategoryModel(json: json);
    }
    return null;
  }
}