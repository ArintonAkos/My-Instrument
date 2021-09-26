import 'package:my_instrument/services/models/responses/base_response.dart';
import 'package:my_instrument/services/models/responses/main/listing/listing_model.dart';

class ListingResponse extends BaseResponse {
  late final ListingModel listing;

  ListingResponse(Map<String, dynamic> json) : super(json) {
    this.listing = ListingModel.fromJson(json);
  }
}