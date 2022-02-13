import 'package:my_instrument/src/shared/utils/parsable_date_time.dart';

class PublicRatingModel {
  late final int value;
  late final String title;
  late final String description;
  late final ParsableDateTime creationDate;
  late final String userId;
  late final String userName;
  late final String userImagePath;
  late final String userImageHash;

  PublicRatingModel({
    Map<String, dynamic>? json
  }) {
    value = json?['value'] ?? 0;
    title = json?['title'] ?? '';
    description = json?['description'] ?? '';
    creationDate = ParsableDateTime.fromString(json?['refreshTokenExpires'], toLocale: false);
    userId = json?['userId'] ?? '';
    userName = json?['userName'] ?? '';
    userImagePath = json?['userImagePath'] ?? '';
    userImageHash = json?['userImageHash'] ?? '';
  }

  factory PublicRatingModel.fromJson(Map<String, dynamic> json) {
    return PublicRatingModel(json: json);
  }
}