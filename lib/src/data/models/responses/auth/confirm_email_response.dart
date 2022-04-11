import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart';

class ConfirmEmailResponse extends BaseResponse {
  late final int remainingTries;

  ConfirmEmailResponse(Map<String, dynamic> json,
      AppLanguage appLanguage) : super(json, appLanguage) {
    remainingTries = int.tryParse(json['remainingTries']) ?? 0;
  }
}