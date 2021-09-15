import 'package:flutter/cupertino.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';

class CategoryModel {
  Map<String, dynamic>? json;
  CategoryModel({
    required this.json
  }) {
    id = json?['id'] ?? -1;
    name_en = json?['nameEn'] ?? '';
    name_hu = json?['nameHu'] ?? '';
    name_ro = json?['nameRo'] ?? '';
    imagePath = json?['imagePath'];
    children = parseChildren();
  }

  late final int id;
  late final String name_en;
  late final String name_hu;
  late final String name_ro;
  late final String? imagePath;
  late final List<CategoryModel>? children;

  String getCategoryName(BuildContext context) {
    Locale? appLocale = AppLocalizations.of(context)?.locale;
    if (appLocale != null) {
      if (appLocale == const Locale("hu")) {
        return this.name_hu;
      } else if (appLocale == const Locale("ro")) {
        return this.name_ro;
      } else {
        return this.name_en;
      }
    }
    return "";
  }

  List<CategoryModel>? parseChildren() {
    Map<String, dynamic>? children = json?['children'];
    if (children != null) {
      List<CategoryModel> list = [];
      children.forEach((key, value) {
        var cat = parseCategoryModel(value);
        if (cat != null) {
          list.add(cat);
        }
      });
      return list;
    }
    return null;
  }

  CategoryModel? parseCategoryModel(Map<String, dynamic> json) {
    if (json['id'] != null) {
      return CategoryModel(json: json);
    }
    return null;
  }
}