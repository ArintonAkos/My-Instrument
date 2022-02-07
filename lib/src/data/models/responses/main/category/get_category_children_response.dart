import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart';

import 'category_model.dart';

class GetCategoryChildrenResponse extends BaseResponse {
  late final CategoryModel data;

  GetCategoryChildrenResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    data = parseCategory(json);
  }

  CategoryModel parseCategory(Map<String, dynamic> json) {
    return CategoryModel(json: json['data']);
  }
}