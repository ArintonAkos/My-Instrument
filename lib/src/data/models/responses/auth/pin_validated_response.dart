import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart';

class PinValidatedResponse extends BaseResponse {
  late final String token;

  PinValidatedResponse(Map<String, dynamic> json, AppLanguage appLanguage)
      : super(json, appLanguage) {
    token = json['token'] ?? '';
  }

}