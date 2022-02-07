import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/src/shared/utils/list_parser.dart';


class CategoryModel extends Equatable {
  Map<String, dynamic>? json;
  CategoryModel({
    required this.json,
    bool shouldParseChildren = true
  }) {
    id = json?['categoryId'] ?? -1;
    nameEn = json?['categoryNameEn'] ?? '';
    nameHu = json?['categoryNameHu'] ?? '';
    nameRo = json?['categoryNameRo'] ?? '';
    imagePath = json?['imagePath'];
    imageHash = json?['imageHash'];

    if (shouldParseChildren) {
      children = ListParser.parse<CategoryModel>(json?['childrenCategories'], parseCategoryModel);
    } else {
      children = [];
    }
  }

  CategoryModel copyWith({ int? id }) {
    Map<String, dynamic> data = {
      "id": id ?? this.id,
      "nameEn": nameEn,
      "nameHu": nameHu,
      "nameRo": nameRo,
      "imagePath": imagePath,
      "imageHash": imageHash,
      "children": children
    };
    return CategoryModel(json: data);
  }

  factory CategoryModel.base() {
    Map<String, dynamic> data = {
      "categoryId": 0,
      "categoryNameEn": "Categories",
      "categoryNameHu": "Kategóriák",
      "categoryNameRo": "Categorii",
      "imagePath": "",
      "imageHash": "",
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

  bool get isLastElement {
    return (children.isEmpty);
  }

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
    if (json['categoryId'] != null) {
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
    children
  ];
}