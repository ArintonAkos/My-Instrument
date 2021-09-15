import 'package:my_instrument/services/models/responses/base_response.dart';

class LoginResponse extends BaseResponse {
  late final String Token;
  late final DateTime? TokenExpires;
  late final String RefreshToken;
  late final DateTime? RefreshTokenExpires;

  LoginResponse(Map<String, dynamic> json) : super(json) {
    Token = json['token'];
    TokenExpires = this.tryParseStr(json['tokenExpires']);
    RefreshToken = json['refreshToken'];
    RefreshTokenExpires = this.tryParseStr(json['refreshTokenExpires']);
  }
}