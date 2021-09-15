import 'package:my_instrument/services/models/responses/base_response.dart';

class RefreshTokenResponse extends BaseResponse {
  late final String Token;
  late final DateTime TokenExpires;
  late final String RefreshToken;
  late final DateTime RefreshTokenExpires;

  RefreshTokenResponse(Map<String, dynamic> json) : super(json) {
    Token = json['token'];
    TokenExpires = json['tokenExpires'];
    RefreshToken = json['refreshToken'];
    RefreshTokenExpires = json['refreshTokenExpires'];
  }
}