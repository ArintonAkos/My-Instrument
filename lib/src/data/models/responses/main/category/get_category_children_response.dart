import 'package:my_instrument/src/data/models/responses/base_response.dart';

import 'category_model.dart';

class GetCategoryChildrenResponse extends BaseResponse {
  late final CategoryModel data;

  GetCategoryChildrenResponse(Map<String, dynamic> json) : super(json) {
    data = parseCategory(json);
  }

  CategoryModel parseCategory(Map<String, dynamic> json) {
    return CategoryModel(json: json['data']);
  }
}