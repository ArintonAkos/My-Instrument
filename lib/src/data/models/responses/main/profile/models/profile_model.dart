import 'package:my_instrument/src/shared/utils/list_parser.dart';
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

  factory BaseProfileModel.fromJson(Map<String, dynamic> json) {
    return BaseProfileModel(json: json);
  }
}

class ProfileModel extends BaseProfileModel {
  late final List<ListingModel> listings;
  late final double rating;

  ProfileModel({
    Map<String, dynamic>? json
  }) : super(json: json) {
    rating = json?['rating'] ?? 0;
    listings = ListParser.parse<ListingModel>(json?['listings'], ListingModel.fromJson);
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(json: json);
  }
}