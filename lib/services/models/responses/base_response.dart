import 'package:flutter/cupertino.dart';
import 'package:my_instrument/services/models/responses/error_response.dart';

class BaseResponse {
  late final String Message;
  late final int StatusCode;
  late final String Status;
  late final int Language;

  BaseResponse(Map<String, dynamic> json) {
    Message = json['message'] ?? '';
    StatusCode = json['statusCode'] ?? 0;
    Status = json['status'] ?? '';
    Language = json['language'] ?? 0;
  }

  factory BaseResponse.error({ language = 0 }) {
    var errorResponse = ErrorResponse(language: language).ResponseJSON;
    Map<String, dynamic> json = {
      'message': errorResponse['message'],
      'statusCode': 404,
      'status': errorResponse['status'],
      'language': language
    };
    return BaseResponse(json);
  }

  get OK {
    return (StatusCode / 100 == 2 || this.Status == 'Success');
  }

  DateTime? tryParseStr(String? dateStr) {
    if (dateStr == null) {
      return null;
    }
    return DateTime.tryParse(dateStr);
  }
}