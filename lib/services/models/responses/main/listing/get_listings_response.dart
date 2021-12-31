import 'package:my_instrument/services/models/responses/base_response.dart';
import 'package:my_instrument/services/models/responses/main/listing/listing_model.dart';
import 'package:my_instrument/shared/utils/list_parser.dart';

class GetListingsResponse extends BaseResponse {
  late final List<ListingModel> listings;

  GetListingsResponse(Map<String, dynamic> json) : super(json) {
    listings = ListParser.parse<ListingModel>(json['listings'], ListingModel.fromJson);
  }
}