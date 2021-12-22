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
import 'package:my_instrument/services/models/responses/base_response.dart' as my_base_response;

class AuthService extends HttpService {

  Future<my_base_response.BaseResponse> login(LoginRequest request) async {
    Response res = await this.postJson(request, AuthConstants.loginURL);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      LoginResponse loginResponse = LoginResponse(body);
      return loginResponse;
    }

    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> register(RegisterRequest request) async {
    Response res = await this.postJson(request, AuthConstants.registerURL);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      RegisterResponse registerResponse = RegisterResponse(body);
      return registerResponse;
    }

    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> refreshToken(RefreshTokenRequest request) async {
    Response res = await this.postJson(request, AuthConstants.refreshTokenURL);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      RefreshTokenResponse refreshTokenResponse = RefreshTokenResponse(body);
      return refreshTokenResponse;
    }

    return my_base_response.BaseResponse.error();
  }
}