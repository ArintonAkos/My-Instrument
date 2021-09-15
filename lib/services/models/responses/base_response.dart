import 'package:flutter/cupertino.dart';

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