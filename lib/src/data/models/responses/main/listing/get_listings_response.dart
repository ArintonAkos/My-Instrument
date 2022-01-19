import 'package:my_instrument/src/shared/utils/list_parser.dart';

import '../../base_response.dart';
import 'listing_model.dart';

class GetListingsResponse extends BaseResponse {
  late final List<ListingModel> listings;

  GetListingsResponse(Map<String, dynamic> json) : super(json) {
    listings = ListParser.parse<ListingModel>(json['listings'], ListingModel.fromJson);
  }
}