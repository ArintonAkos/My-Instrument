import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:my_instrument/src/data/data_providers/services/auth_service.dart';
import 'package:my_instrument/src/shared/data/custom_status_codes.dart';
import 'package:my_instrument/src/shared/exceptions/more_info_required_exception.dart';
import 'package:my_instrument/src/shared/exceptions/uninitialized_exception.dart';
import 'package:my_instrument/src/shared/utils/parse_methods.dart';
import 'package:my_instrument/src/data/models/repository_models/user.dart';
import 'package:my_instrument/src/data/models/requests/auth/login_request.dart';
import 'package:my_instrument/src/data/models/requests/auth/refresh_token_request.dart';
import 'package:my_instrument/src/data/models/requests/auth/register_request.dart';
import 'package:my_instrument/src/data/models/responses/auth/db_external_login_response.dart';
import 'package:my_instrument/src/data/models/responses/auth/login_response.dart';
import 'package:my_instrument/src/data/models/responses/auth/refresh_token_response.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/responses/future_response.dart';

enum ExternalLoginType {
  google,
  facebook
}

class AuthModel {
  User? _user;
  SharedPreferences? prefs;

  final _controller = StreamController<bool>();
  Stream get authStream => _controller.stream;

  void disposeAuthStream() => _controller.close();

  bool get isSignedIn {
    return (
        _user?.token != null &&
        _user?.refreshToken != null &&
        _user?.tokenExpires?.dateTime != null &&
        _user?.refreshTokenExpires?.dateTime != null)
    ;
  }

  String? get userId {
    return _user?.userId;
  }

  late final AuthService authService;

  Future init() async {
    authService = appInjector.get<AuthService>();
    prefs = await SharedPreferences.getInstance();

    if (prefs?.getBool('signedIn') == true) {
      String? userPref = prefs?.getString('user');
      _user = ParseMethods.fromJsonString(userPref);

      if (_user?.email != null) {
        await ensureAuthorized();
        _controller.sink.add(true);
      } else {
        await signOut();
      }
    }
  }

  Future<FutureResponse> signIn(String email, String password, { bool? rememberMe }) async {
    try {
      if (prefs == null) {
        throw UninitializedException(CallerClass.sharedPreferences);
      }
      var response = await authService.login(LoginRequest(email: email, password: password));

      if (response.ok) {
        _user = (response as LoginResponse).applicationUser;

        if (rememberMe == true) {
          await prefs?.setBool('signedIn', true);
          await saveUserToPrefs();
        }

      } else {
        if (response.statusCode == 409) {
          await signOut();
        }

        return FutureResponse(exception: response.message);
      }
    } catch (e) {
      return FutureResponse(exception: e);
    }

    _controller.sink.add(true);
    return FutureResponse();
  }

  Future<FutureResponse> externalLogin(ExternalLoginType loginType) async {
    try {
      BaseResponse response;

      switch(loginType) {
        case ExternalLoginType.facebook:
          response = await authService.facebookExternalLogin();
          break;
        default:
          response = await authService.googleExternalLogin();
          break;
      }

      if (response.ok) {
        var loginResponse = response as LoginResponse;

        _user = loginResponse.applicationUser;

        await prefs?.setBool('signedIn', true);
        saveUserToPrefs();

      } else if (response.statusCode == CustomStatusCode.moreInfoRequired) {
        var dbResponse = response as DbExternalLoginResponse;

        return FutureResponse(
          data: dbResponse,
          exception: MoreInfoRequiredException()
        );
      }

    } catch (e) {
      return FutureResponse(exception: e);
    }

    _controller.sink.add(true);
    return FutureResponse();
  }

  Future<FutureResponse> register(RegisterRequest request) async {
    try {
      var response = await authService.register(request);

      if (!response.ok) {
        return FutureResponse(exception: response.message);
      }
    } catch (e) {
      return FutureResponse(exception: e);
    }

    return FutureResponse();
  }

  Future<FutureResponse> refreshToken(RefreshTokenRequest request) async {
    int? statusCode;

    try {
      var response = await authService.refreshToken(request);

      if (response.ok) {
        response = response as RefreshTokenResponse;
        statusCode = response.statusCode;

        if (response.statusCode != CustomStatusCode.notExpired) {
          _user?.token = response.token;
          _user?.tokenExpires = response.tokenExpires;
          _user?.refreshToken = response.refreshToken;
          _user?.refreshTokenExpires = response.refreshTokenExpires;
          await saveUserToPrefs();
        }
      } else {
        if (response.statusCode == 409) {
          await signOut();
        }

        return FutureResponse(exception: response.message);
      }
    } catch (e) {
      return FutureResponse(exception: e);
    }

    return FutureResponse(statusCode: statusCode);
  }

  Future<FutureResponse> signOut() async {
    await prefs?.remove('signedIn');
    await prefs?.remove('user');
    await prefs?.remove('token');
    await prefs?.remove('newListingPage');
    _user = null;
    _controller.sink.add(false);
    return FutureResponse();
  }

  Future<bool> ensureAuthorized() async {
    if (_user?.tokenExpires?.dateTime == null || _user?.refreshTokenExpires?.dateTime == null) {
      await signOut();
      return false;
    }
    if (_user?.tokenExpires?.dateTime?.isBefore(DateTime.now().toUtc()) == true) {
      var token = _user?.token ?? '';
      var refreshToken = _user?.refreshToken ?? '';

      var result = await this.refreshToken(RefreshTokenRequest(
          token: token,
          refreshToken: refreshToken
      ));

      if (!result.success) {
        if (result.statusCode == 403 || result.statusCode == 409) {
          await signOut();
        }

        return false;
      }
    }
    return true;
  }

  Future<String> getAccessToken() async {
    if (await ensureAuthorized()) {
      return _user?.token ?? '';
    }

    return '';
  }

  DateTime? tryParseInt(int? timeStamp) {
    if (timeStamp == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(timeStamp, isUtc: true);
  }

  User? getUser() {
    return _user;
  }

  saveUserToPrefs() async {
    if (prefs != null && _user != null) {
      await prefs?.setString('user', jsonEncode(_user));
      await prefs?.setString('token', _user?.token ?? '');
      await prefs?.setBool('signedIn', true);
    }
  }
}