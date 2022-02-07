import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/models/repository_models/user.dart';

import '../base_response.dart';

class LoginResponse extends BaseResponse {
  late final User applicationUser;

  LoginResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    applicationUser = User.fromJson(json);
  }
}