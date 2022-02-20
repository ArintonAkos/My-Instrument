import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart';
import 'package:my_instrument/src/shared/utils/list_parser.dart';

import 'filter_model.dart';

class GetCategoryFiltersResponse extends BaseResponse {
  late final List<FilterModel> filters;

  GetCategoryFiltersResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    filters = ListParser.parse<FilterModel>(json['data'], FilterModel.fromJson);
  }
}