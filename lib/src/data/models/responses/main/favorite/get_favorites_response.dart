import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/shared/utils/parse_methods.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart';

class GetFavoritesResponse extends BaseResponse {
  late final List<String> favorites;

  GetFavoritesResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    favorites = ParseMethods.parseStringList(json['favorites']);
  }
}