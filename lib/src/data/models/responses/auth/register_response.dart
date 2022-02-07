import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';

import '../base_response.dart';

class RegisterResponse extends BaseResponse {
  RegisterResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage);
}