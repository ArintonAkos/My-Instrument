import 'error_response.dart';

class BaseResponse {
  late final String message;
  late final int statusCode;
  late final String status;
  late final int language;

  BaseResponse(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    statusCode = json['statusCode'] ?? 0;
    status = json['status'] ?? '';
    language = json['language'] ?? 0;
  }

  factory BaseResponse.error({ language = 0 }) {
    var errorResponse = ErrorResponse(language: language).responseJSON;
    Map<String, dynamic> json = {
      'message': errorResponse['message'],
      'statusCode': 404,
      'status': errorResponse['status'],
      'language': language
    };
    return BaseResponse(json);
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