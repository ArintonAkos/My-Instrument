import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/services/http_service.dart';
import 'package:my_instrument/services/models/requests/auth/login_request.dart';
import 'package:my_instrument/services/models/requests/auth/refresh_token_request.dart';
import 'package:my_instrument/services/models/requests/auth/register_request.dart';
import 'package:my_instrument/services/models/responses/auth/auth_constants.dart';
import 'package:my_instrument/services/models/responses/auth/login_response.dart';
import 'package:my_instrument/services/models/responses/auth/refresh_token_response.dart';
import 'package:my_instrument/services/models/responses/auth/register_response.dart';
import 'package:my_instrument/services/models/responses/base_response.dart' as MyBaseResponse;

class AuthService extends HttpService {

  Future<MyBaseResponse.BaseResponse> login(LoginRequest request) async {
    Response res = await this.postJson(request, AuthConstants.LoginURL);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      LoginResponse loginResponse = LoginResponse(body);
      return loginResponse;
    }

    return MyBaseResponse.BaseResponse.error();
  }

  Future<MyBaseResponse.BaseResponse> register(RegisterRequest request) async {
    Response res = await this.postJson(request, AuthConstants.RegisterURL);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      RegisterResponse registerResponse = RegisterResponse(body);
      return registerResponse;
    }

    return MyBaseResponse.BaseResponse.error();
  }

  Future<MyBaseResponse.BaseResponse> refreshToken(RefreshTokenRequest request) async {
    Response res = await this.postJson(request, AuthConstants.RefreshTokenURL);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      RefreshTokenResponse refreshTokenResponse = RefreshTokenResponse(body);
      return refreshTokenResponse;
    }

    return MyBaseResponse.BaseResponse.error();
  }
}