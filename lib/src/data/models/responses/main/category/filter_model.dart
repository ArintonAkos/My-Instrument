import 'package:flutter/material.dart';
import 'package:my_instrument/src/shared/utils/translation_methods.dart';

import '../../../../../shared/utils/list_parser.dart';
import 'filter_entry_model.dart';

class FilterModel {
  final int filterId;
  final String filterNameEn;
  final String filterNameHu;
  final String filterNameRo;
  final List<FilterEntryModel> filterEntries;

  FilterModel({
    required this.filterId,
    required this.filterNameEn,
    required this.filterNameHu,
    required this.filterNameRo,
    required this.filterEntries
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      filterId: json['filterId'],
      filterNameEn: json['filterNameEn'],
      filterNameHu: json['filterNameHu'],
      filterNameRo: json['filterNameRo'],
      filterEntries: ListParser.parse<FilterEntryModel>(json['filterEntries'], FilterEntryModel.fromJson)
    );
  }

  String getFilterName(BuildContext context) {
    return TranslationMethods.translateName(context,
      filterNameEn,
      filterNameHu,
      filterNameRo
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'filterId': filterId,
      'filterNameEn': filterNameEn,
      'filterNameHu': filterNameHu,
      'filterNameRo': filterNameRo,
      'filterEntries': filterEntries
    };
  }
}