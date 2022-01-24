import 'package:my_instrument/src/data/data_providers/services/category_service.dart';
import 'package:my_instrument/src/data/models/responses/main/category/get_category_children_response.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_response.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';

class CategoryRepository {
  final CategoryService _categoryService = appInjector.get<CategoryService>();

  Future<List<CategoryModel>> getBaseCategoriesWithChildren() async {
    var res = await _categoryService.getBaseCategoriesWithChildren();

    if (res.ok) {
      return (res as CategoryResponse).data;
    }

    throw Exception(res.message);
  }

  Future<List<CategoryModel>> getCategoryWithChildren(int categoryId, { int language = 0 }) async {
    var res = await _categoryService.getCategoryWithChildren(categoryId);

    if (res.ok) {
      return (res as GetCategoryChildrenResponse).data.children;
    }

    throw Exception(res.message);
  }
}