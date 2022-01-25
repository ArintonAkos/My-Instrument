import 'package:my_instrument/src/data/models/responses/main/profile/profile_model.dart';

import '../../base_response.dart';
import '../../error_response.dart';

class BaseProfileResponse extends BaseResponse {
  late final BaseProfileModel? data;

  BaseProfileResponse(Map<String, dynamic> json) : super(json) {
    data = parseBaseProfile(json);
  }

  BaseProfileModel? parseBaseProfile(Map<String, dynamic> json) {
    dynamic data = json['profile'];

    if (data != null) {
      return BaseProfileModel(json: data);
    }

    return null;
  }

  factory BaseProfileResponse.errorMessage({int language = 0}) {
    return BaseProfileResponse(ErrorResponse(language: language).responseJSON);
  }
}