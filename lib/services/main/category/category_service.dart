import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/services/http_service.dart';
import 'package:my_instrument/services/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/services/models/responses/main/category/category_constants.dart';
import 'package:my_instrument/services/models/responses/main/category/category_response.dart';

class CategoryService extends HttpService {
  Future<my_base_response.BaseResponse> getBaseCategoriesWithChildren({ int language = 0 }) async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(CategoryConstants.baseWithChildrenURL + '?language=$language');

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        CategoryResponse response = CategoryResponse(body);
        return response;
      }
    }
    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> getCategoryWithChildren(int categoryId, { int language = 0}) async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(CategoryConstants.baseWithChildrenURL +
          '?categoryId=$categoryId&language=$language');

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        CategoryResponse response = CategoryResponse(body);
        return response;
      }
    }
    return my_base_response.BaseResponse.error();
  }
}