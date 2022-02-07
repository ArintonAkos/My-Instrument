import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';

import '../../base_response.dart';
import '../../error_response.dart';
import 'category_model.dart';

class CategoryResponse extends BaseResponse {
  late final List<CategoryModel> data;

  CategoryResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    data = parseCategories(json);
  }

  List<CategoryModel> parseCategories(Map<String, dynamic> json) {
    List<Map<String, dynamic>>? data = List<Map<String, dynamic>>.from(json['data']);

    List<CategoryModel> categoryList = [];
    for (var value in data) {
      categoryList.add(CategoryModel(json: value));
    }

    return categoryList;
  }

  factory CategoryResponse.errorMessage(AppLanguage appLanguage) {
    return CategoryResponse(ErrorResponse(language: appLanguage.localeIndex).responseJSON, appLanguage);
  }
}
