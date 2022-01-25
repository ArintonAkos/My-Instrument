import 'package:my_instrument/services/models/responses/main/listing/listing_model.dart';

import '../../../../../shared/utils/list_parser.dart';

class BaseProfileModel {

  late final String id;
  late final String baseName;

  BaseProfileModel({
    Map<String, dynamic>? json
  }) {
    id = json?['userId'];
    baseName = json?['baseName'];
  }
}

class ProfileModel extends BaseProfileModel {
  late final List<ListingModel> listings;

  ProfileModel({
    Map<String, dynamic>? json
  }) : super(json: json) {
    listings = ListParser.parse<ListingModel>(json?['listings'], ListingModel.fromJson);
  }
}