import '../../base_response.dart';
import '../../error_response.dart';
import 'category_model.dart';

class CategoryResponse extends BaseResponse {
  late final List<CategoryModel>? data;

  CategoryResponse(Map<String, dynamic> json) : super(json) {
    this.data = parseCategories(json);
  }

  List<CategoryModel>? parseCategories(Map<String, dynamic> json) {
    Map<String, dynamic>? data = json['data'];
    if (data != null) {
      List<CategoryModel> categoryList = [];
      data.forEach((key, value) {
        categoryList.add(CategoryModel(json: value));
      });
      return categoryList;
    }
    return null;
  }

  factory CategoryResponse.errorMessage({ int language = 0}) {
    return CategoryResponse(ErrorResponse(language: language).ResponseJSON);
  }
}