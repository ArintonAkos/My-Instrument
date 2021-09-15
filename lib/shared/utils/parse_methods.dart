import 'dart:convert';

import 'package:my_instrument/services/models/user.dart';

class ParseMethods {
  static List<String> parseStringList(List<dynamic>? jsonData) {
    if (jsonData != null) {
      return jsonData.cast<String>();
    }
    return [];
  }

  static User? fromJsonString(String? jsonString) {
    if (jsonString != null) {
      Map<String, dynamic> json = jsonDecode(jsonString) as Map<String, dynamic>;
      return User.fromJson(json);
    }
    return null;
  }
}