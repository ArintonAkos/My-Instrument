import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';

import '../base_response.dart';

class DbExternalLoginResponse extends BaseResponse {
  final String email;
  final String? firstName;
  final String? lastName;
  final String name;

  DbExternalLoginResponse(
    Map<String, dynamic> json, AppLanguage appLanguage, {
    required this.email,
    this.firstName,
    this.lastName,
    required this.name
  }) : super(json, appLanguage);
}