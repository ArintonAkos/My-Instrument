import 'package:my_instrument/services/models/responses/base_response.dart';

class DbExternalLoginResponse extends BaseResponse{
  final String email;
  final String? firstName;
  final String? lastName;
  final String name;

  DbExternalLoginResponse(
    Map<String, dynamic> json, {
    required this.email,
    this.firstName,
    this.lastName,
    required this.name
  }) : super(json);
}