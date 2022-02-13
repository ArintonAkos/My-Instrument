import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/models/responses/main/profile/models/profile_model.dart';

import '../../../base_response.dart';
import '../../../error_response.dart';

class BaseProfileResponse extends BaseResponse {
  late final BaseProfileModel data;

  BaseProfileResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    data = BaseProfileModel.fromJson(json);
  }
}