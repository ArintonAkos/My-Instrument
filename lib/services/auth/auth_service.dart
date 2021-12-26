import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/services/auth/facebook_login_service.dart';
import 'package:my_instrument/services/http_service.dart';
import 'package:my_instrument/services/models/requests/auth/external_login_request.dart';
import 'package:my_instrument/services/models/requests/auth/login_request.dart';
import 'package:my_instrument/services/models/requests/auth/refresh_token_request.dart';
import 'package:my_instrument/services/models/requests/auth/register_request.dart';
import 'package:my_instrument/services/models/responses/auth/auth_constants.dart';
import 'package:my_instrument/services/models/responses/auth/external_login_response.dart';
import 'package:my_instrument/services/models/responses/auth/login_response.dart';
import 'package:my_instrument/services/models/responses/auth/refresh_token_response.dart';
import 'package:my_instrument/services/models/responses/auth/register_response.dart';
import 'package:my_instrument/services/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/shared/data/custom_status_codes.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';

import 'google_login_service.dart';

class AuthService extends HttpService {
  final GoogleLoginService _googleLoginService = appInjector.get<GoogleLoginService>();
  final FacebookLoginService _facebookLoginService = appInjector.get<FacebookLoginService>();

  Future<my_base_response.BaseResponse> login(LoginRequest request) async {
    Response res = await postJson(request, AuthConstants.loginURL);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      LoginResponse loginResponse = LoginResponse(body);
      return loginResponse;
    }

    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> googleExternalLogin() async {
    ExternalLoginResponse data = await _googleLoginService.authenticateInDb();

    return _externalLogin(ExternalLoginRequest(
        accessToken: data.accessToken ?? '',
        loginProvider: 'Google',
        providerKey: data.id ?? '',
        emailAddress: data.email ?? ''
    ));
  }

  Future<my_base_response.BaseResponse> facebookExternalLogin() async {
    ExternalLoginResponse data = await _facebookLoginService.authenticateInDb();

    return _externalLogin(ExternalLoginRequest(
        accessToken: data.accessToken ?? '',
        loginProvider: 'Facebook',
        providerKey: data.id ?? '',
        emailAddress: data.email ?? ''
    ));
  }

  Future<my_base_response.BaseResponse> _externalLogin(ExternalLoginRequest request) async {
    Response res = await postJson(request, AuthConstants.externalLoginURL);

    if (res.statusCode == 200 || res.statusCode == CustomStatusCode.moreInfoRequired) {
      dynamic body  = jsonDecode(res.body);

      my_base_response.BaseResponse response = my_base_response.BaseResponse(body);
      return response;
    }

    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> register(RegisterRequest request) async {
    Response res = await postJson(request, AuthConstants.registerURL);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      RegisterResponse registerResponse = RegisterResponse(body);
      return registerResponse;
    }

    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> refreshToken(RefreshTokenRequest request) async {
    Response res = await postJson(request, AuthConstants.refreshTokenURL);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      RefreshTokenResponse refreshTokenResponse = RefreshTokenResponse(body);
      return refreshTokenResponse;
    }

    return my_base_response.BaseResponse.error();
  }
}