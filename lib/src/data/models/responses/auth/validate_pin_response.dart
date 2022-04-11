import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart';

class ValidatePinResponse extends BaseResponse {
  late final int remainingTries;

  ValidatePinResponse(Map<String, dynamic> json, AppLanguage appLanguage)
    : super(json, appLanguage) {
    remainingTries = json['remainingTries'] ?? '';
  }
}