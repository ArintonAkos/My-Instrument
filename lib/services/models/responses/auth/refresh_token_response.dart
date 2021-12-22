import 'package:my_instrument/services/models/responses/base_response.dart';
import 'package:my_instrument/shared/utils/parsable_date_time.dart';

class RefreshTokenResponse extends BaseResponse {
  late final String token;
  late final ParsableDateTime? tokenExpires;
  late final String refreshToken;
  late final ParsableDateTime? refreshTokenExpires;


  RefreshTokenResponse(Map<String, dynamic> json) : super(json) {
    token = json['token'];
    tokenExpires = ParsableDateTime.fromString(json['tokenExpires']);
    refreshToken = json['refreshToken'];
    refreshTokenExpires = ParsableDateTime.fromString(json['refreshTokenExpires']);
  }
}