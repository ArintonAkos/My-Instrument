import '../../base_response.dart';
import 'listing_model.dart';

class ListingResponse extends BaseResponse {
  late final ListingModel listing;

  ListingResponse(Map<String, dynamic> json) : super(json) {
    listing = ListingModel.fromJson(json);
  }
}