import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';

import '../../base_response.dart';
import 'listing_model.dart';

class ListingResponse extends BaseResponse {
  late final ListingModel listing;

  ListingResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    listing = ListingModel.fromJson(json['listing']);
  }
}