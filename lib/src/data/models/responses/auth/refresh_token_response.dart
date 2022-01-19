import 'package:my_instrument/src/shared/utils/parsable_date_time.dart';

import '../base_response.dart';

class RefreshTokenResponse extends BaseResponse {
  late final String token;
  late final ParsableDateTime? tokenExpires;
  late final String refreshToken;
  late final ParsableDateTime? refreshTokenExpires;


  RefreshTokenResponse(Map<String, dynamic> json) : super(json) {
    token = json['token'];
    tokenExpires = ParsableDateTime.fromString(json['tokenExpires'], toLocale: false);
    refreshToken = json['refreshToken'];
    refreshTokenExpires = ParsableDateTime.fromString(json['refreshTokenExpires'], toLocale: false);
  }
}