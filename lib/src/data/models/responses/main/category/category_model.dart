import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/src/shared/utils/list_parser.dart';


class CategoryModel extends Equatable {
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
    isLastElement = json?['isLastElement'];
    children = ListParser.parse<CategoryModel>(json?['children'], parseCategoryModel);

  }

  CategoryModel copyWith({ int? id }) {
    Map<String, dynamic> data = {
      "id": id ?? this.id,
      "nameEn": nameEn,
      "nameHu": nameHu,
      "nameRo": nameRo,
      "imagePath": imagePath,
      "imageHash": imageHash,
      "isLastElement": isLastElement,
      "children": children
    };
    return CategoryModel(json: data);
  }

  factory CategoryModel.base() {
    Map<String, dynamic> data = {
      "id": 0,
      "nameEn": "Categories",
      "nameHu": "Kategóriák",
      "nameRo": "Categorii",
      "imagePath": "",
      "imageHash": "",
      "isLastElement": false,
      "children": []
    };
    return CategoryModel(json: data);
  }

  late int id;
  late final String nameEn;
  late final String nameHu;
  late final String nameRo;
  late final String? imagePath;
  late final String? imageHash;
  late final List<CategoryModel> children;
  late final bool isLastElement;

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

  static CategoryModel? parseCategoryModel(Map<String, dynamic> json) {
    if (json['id'] != null) {
      return CategoryModel(json: json);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'nameEn': nameEn,
      'nameHu': nameHu,
      'nameRo': nameRo,
      'imagePath': imagePath,
      'imageHash': imageHash,
      'isLastElement': isLastElement,
      'children': children,
    };
  }

  @override
  List<Object?> get props => [
    id,
    nameEn,
    nameHu,
    nameRo,
    imagePath,
    imageHash,
    isLastElement,
    children
  ];
}