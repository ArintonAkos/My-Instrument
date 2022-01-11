import 'package:my_instrument/shared/utils/list_parser.dart';
import 'package:my_instrument/src/data/models/responses/main/listing/listing_model.dart';

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