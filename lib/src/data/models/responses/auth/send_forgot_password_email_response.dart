import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart';

class SendForgotPasswordEmailResponse extends BaseResponse {
  late final String resetPasswordId;

  SendForgotPasswordEmailResponse(Map<String, dynamic> json, AppLanguage appLanguage)
      : super(json, appLanguage) {
    resetPasswordId = json['resetPasswordId'] ?? '';
  }
}