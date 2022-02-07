import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/shared/utils/list_parser.dart';

import '../../base_response.dart';
import 'listing_model.dart';

class GetListingsResponse extends BaseResponse {
  late final List<ListingModel> listings;

  GetListingsResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    listings = ListParser.parse<ListingModel>(json['listings'], ListingModel.fromJson);
  }
}