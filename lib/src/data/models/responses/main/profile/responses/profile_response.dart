import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/models/responses/main/profile/models/profile_model.dart';

import '../../../base_response.dart';
import '../../../error_response.dart';

class ProfileResponse extends BaseResponse {
  late final ProfileModel? data;

  ProfileResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    data = parseProfile(json);
  }

  ProfileModel? parseProfile(Map<String, dynamic> json) {
    dynamic data = json['data'];

    if (data != null) {
      return ProfileModel(json: data);
    }

    return null;
  }

  factory ProfileResponse.errorMessage(AppLanguage appLanguage) {
    return ProfileResponse(ErrorResponse(language: appLanguage.localeIndex).responseJSON, appLanguage);
  }
}
