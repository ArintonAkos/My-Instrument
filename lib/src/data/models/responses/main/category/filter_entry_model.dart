import 'package:flutter/cupertino.dart';
import 'package:my_instrument/src/shared/utils/translation_methods.dart';

class FilterEntryModel {
  final int filterEntryId;
  final String filterEntryNameEn;
  final String filterEntryNameHu;
  final String filterEntryNameRo;

  FilterEntryModel({
    required this.filterEntryId,
    required this.filterEntryNameEn,
    required this.filterEntryNameHu,
    required this.filterEntryNameRo
  });

  factory FilterEntryModel.fromJson(Map<String, dynamic> json) {
    return FilterEntryModel(
        filterEntryId: json['filterEntryId'],
        filterEntryNameEn: json['filterEntryNameEn'],
        filterEntryNameHu: json['filterEntryNameHu'],
        filterEntryNameRo: json['filterEntryNameRo']
    );
  }

  String getFilterEntryName(BuildContext context) {
    return TranslationMethods.translateName(context,
        filterEntryNameEn,
        filterEntryNameHu,
        filterEntryNameRo
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'filterEntryId': filterEntryId,
      'filterEntryNameEn': filterEntryNameEn,
      'filterEntryNameHu': filterEntryNameHu,
      'filterEntryNameRo': filterEntryNameRo
    };
  }

  @override
  String toString() {
    return '''{
     'filterEntryId': $filterEntryId,
     'filterEntryNameEn': '$filterEntryNameEn',
     'filterEntryNameHu': '$filterEntryNameHu',
     'filterEntryNameRo': '$filterEntryNameRo' 
    }''';
  }
}