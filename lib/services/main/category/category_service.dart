import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/services/http_service.dart';
import 'package:my_instrument/services/models/responses/base_response.dart' as MyBaseResponse;
import 'package:my_instrument/services/models/responses/main/category/category_constants.dart';
import 'package:my_instrument/services/models/responses/main/category/category_response.dart';

class CategoryService extends HttpService {
  Future<MyBaseResponse.BaseResponse> getBaseCategoriesWithChildren({ int language = 0 }) async {
    if (await this.model.ensureAuthorized()) {
      Response res = await getData(CategoryConstants.BaseWithChildrenURL + '?language=${language}');

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        CategoryResponse response = CategoryResponse(body);
        return response;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }

  Future<MyBaseResponse.BaseResponse> getCategoryWithChildren(int categoryId, { int language = 0}) async {
    if (await this.model.ensureAuthorized()) {
      Response res = await getData(CategoryConstants.BaseWithChildrenURL +
          '?categoryId=${categoryId}&language=${language}');

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        CategoryResponse response = CategoryResponse(body);
        return response;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }
}