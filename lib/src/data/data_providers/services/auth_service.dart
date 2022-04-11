import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/data_providers/services/http_service.dart';
import 'package:my_instrument/src/shared/data/custom_status_codes.dart';
import 'package:my_instrument/src/data/data_providers/constants/auth_constants.dart';
import 'package:my_instrument/src/data/models/requests/auth/external_login_request.dart';
import 'package:my_instrument/src/data/models/requests/auth/login_request.dart';
import 'package:my_instrument/src/data/models/requests/auth/refresh_token_request.dart';
import 'package:my_instrument/src/data/models/requests/auth/register_request.dart';
import 'package:my_instrument/src/data/models/responses/auth/db_external_login_response.dart';
import 'package:my_instrument/src/data/models/responses/auth/external_login_response.dart';
import 'package:my_instrument/src/data/models/responses/auth/login_response.dart';
import 'package:my_instrument/src/data/models/responses/auth/refresh_token_response.dart';
import 'package:my_instrument/src/data/models/responses/auth/register_response.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'facebook_login_service.dart';
import 'google_login_service.dart';

class AuthService extends HttpService {
  AuthService({ required AppLanguage appLanguage}) : super(appLanguage: appLanguage);

  final GoogleLoginService _googleLoginService = appInjector.get<GoogleLoginService>();
  final FacebookLoginService _facebookLoginService = appInjector.get<FacebookLoginService>();

  Future<my_base_response.BaseResponse> login(LoginRequest request) async {
    Response res = await postJson(request, AuthConstants.loginURL);

    Map<String, dynamic> body = decodeBody(res.body);
    if (res.statusCode == 200) {
      body['authenticationType'] = 'email';

      LoginResponse loginResponse = LoginResponse(body, appLanguage);
      return loginResponse;
    }

    return my_base_response.BaseResponse.error(appLanguage, responseBody: body);
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
      emailAddress: data.email ?? '',
      name: data.name,
      firstName: data.firstName,
      lastName: data.lastName
    ));
  }

  Future<my_base_response.BaseResponse> _externalLogin(ExternalLoginRequest request) async {
    Response res = await postJson(request, AuthConstants.externalLoginURL);

    if (res.statusCode == 200) {
      Map<String, dynamic> body  = jsonDecode(res.body);
      body['authenticationType'] = request.loginProvider.toLowerCase();

      LoginResponse response = LoginResponse(body, appLanguage);
      return response;
    } else if (res.statusCode == CustomStatusCode.moreInfoRequired) {
      dynamic body = jsonDecode(res.body);

      return DbExternalLoginResponse(
        body,
        appLanguage,
        email: request.emailAddress,
        name: request.name ?? '',
      );
    }

    return my_base_response.BaseResponse.error(appLanguage);
  }

  Future<my_base_response.BaseResponse> register(RegisterRequest request) async {
    Response res = await postJson(request, AuthConstants.registerURL);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      RegisterResponse registerResponse = RegisterResponse(body, appLanguage);
      return registerResponse;
    }

    return my_base_response.BaseResponse.error(appLanguage);
  }

  Future<my_base_response.BaseResponse> refreshToken(RefreshTokenRequest request) async {
    Response res = await postJson(request, AuthConstants.refreshTokenURL);

    Map<String, dynamic> body = jsonDecode(res.body);
    body['statusCode'] = res.statusCode;

    if (res.statusCode == 200) {
      RefreshTokenResponse refreshTokenResponse = RefreshTokenResponse(body, appLanguage);
      return refreshTokenResponse;
    }

    return my_base_response.BaseResponse.error(appLanguage, responseBody: body);
  }
}