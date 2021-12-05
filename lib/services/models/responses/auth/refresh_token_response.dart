import 'package:my_instrument/services/models/responses/base_response.dart';
import 'package:my_instrument/shared/utils/parsable_date_time.dart';

class RefreshTokenResponse extends BaseResponse {
  late final String Token;
  late final ParsableDateTime? TokenExpires;
  late final String RefreshToken;
  late final ParsableDateTime? RefreshTokenExpires;


  RefreshTokenResponse(Map<String, dynamic> json) : super(json) {
    Token = json['token'];
    TokenExpires = ParsableDateTime.fromJson(json['tokenExpires']);
    RefreshToken = json['refreshToken'];
    RefreshTokenExpires = ParsableDateTime.fromJson(json['refreshTokenExpires']);
  }
}