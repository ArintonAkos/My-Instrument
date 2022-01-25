import 'package:my_instrument/src/data/models/responses/main/profile/profile_model.dart';

import '../../base_response.dart';
import '../../error_response.dart';

class ProfileResponse extends BaseResponse {
  late final ProfileModel? data;

  ProfileResponse(Map<String, dynamic> json) : super(json) {
    data = parseProfile(json);
  }

  ProfileModel? parseProfile(Map<String, dynamic> json) {
    dynamic data = json['data'];

    if (data != null) {
      return ProfileModel(json: data);
    }

    return null;
  }

  factory ProfileResponse.errorMessage({int language = 0}) {
    return ProfileResponse(ErrorResponse(language: language).responseJSON);
  }
}
