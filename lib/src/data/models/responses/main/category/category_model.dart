import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/src/shared/utils/list_parser.dart';
import 'package:my_instrument/src/shared/utils/translation_methods.dart';


class CategoryModel extends Equatable {

  static int get defaultId => -1;

  CategoryModel({
    required Map<String, dynamic>? json,
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
      "categoryId": id ?? this.id,
      "categoryNameEn": nameEn,
      "categoryNameHu": nameHu,
      "categoryNameRo": nameRo,
      "imagePath": imagePath,
      "imageHash": imageHash,
      "childrenCategories": children
    };
    return CategoryModel(json: data);
  }

  factory CategoryModel.base() {
    Map<String, dynamic> data = {
      "categoryId": defaultId,
      "categoryNameEn": "Select category",
      "categoryNameHu": "Válassz kategóriát",
      "categoryNameRo": "Selectează categorie",
      "imagePath": "",
      "imageHash": "",
      "childrenCategories": []
    };
    return CategoryModel(json: data);
  }

  late final int id;
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
    return TranslationMethods.translateName(context, nameEn, nameHu, nameRo);
  }

  static CategoryModel? parseCategoryModel(Map<String, dynamic> json) {
    if (json['categoryId'] != null) {
      return CategoryModel(json: json);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'categoryId': id,
      'categoryNameEn': nameEn,
      'categoryNameHu': nameHu,
      'categoryNameRo': nameRo,
      'imagePath': imagePath,
      'imageHash': imageHash,
      'childrenCategories': children,
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