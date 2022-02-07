import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/data_providers/services/http_service.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/src/data/data_providers/constants/category_constants.dart';
import 'package:my_instrument/src/data/models/responses/main/category/get_category_children_response.dart';

class CategoryService extends HttpService {
  CategoryService({ required AppLanguage appLanguage}) : super(appLanguage: appLanguage);

  Future<my_base_response.BaseResponse> getCategoryWithAllChildren(int categoryId) async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(CategoryConstants.categoryAllChildrenURL +
        '?categoryId=$categoryId', concat: true);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        GetCategoryChildrenResponse response = GetCategoryChildrenResponse(body, appLanguage);
        return response;
      }
    }

    return my_base_response.BaseResponse.error(appLanguage);
  }

  Future<my_base_response.BaseResponse> getCategoryWithChildren(int categoryId) async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(CategoryConstants.categoryChildrenURL +
          '?categoryId=$categoryId', concat: true);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        GetCategoryChildrenResponse response = GetCategoryChildrenResponse(body, appLanguage);
        return response;
      }
    }
    return my_base_response.BaseResponse.error(appLanguage);
  }
}