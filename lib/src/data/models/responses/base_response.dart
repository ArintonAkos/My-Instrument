import 'package:http/http.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';

import 'error_response.dart';

class BaseResponse {
  late final String message;
  late final int statusCode;
  late final String status;
  late final int language;
  late final AppLanguage appLanguage;

  BaseResponse(Map<String, dynamic> json, AppLanguage appLanguage) {
    message = json['message'] ?? '';
    statusCode = json['statusCode'] ?? 0;
    status = json['status'] ?? '';
    language = appLanguage.localeIndex;
  }

  factory BaseResponse.error(AppLanguage appLanguage, { Map<String, dynamic>? responseBody }) {
    var errorResponse = ErrorResponse(language: appLanguage.localeIndex).responseJSON;
    Map<String, dynamic> json = {
      'message': responseBody?['message'] ?? errorResponse['message'],
      'statusCode': responseBody?['statusCode'] ?? 404,
      'status': responseBody?['status'] ?? errorResponse['status'],
      'language': responseBody?['language'] ?? appLanguage.localeIndex
    };
    return BaseResponse(json, appLanguage);
  }

  get ok {
    return (statusCode / 100 == 2 || status == 'Success');
  }

  DateTime? tryParseStr(String? dateStr) {
    if (dateStr == null) {
      return null;
    }
    return DateTime.tryParse(dateStr);
  }
}