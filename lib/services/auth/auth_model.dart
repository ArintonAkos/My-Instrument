import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:my_instrument/services/auth/auth_service.dart';
import 'package:my_instrument/services/models/requests/auth/login_request.dart';
import 'package:my_instrument/services/models/requests/auth/refresh_token_request.dart';
import 'package:my_instrument/services/models/requests/auth/register_request.dart';
import 'package:my_instrument/services/models/responses/auth/login_response.dart';
import 'package:my_instrument/services/models/responses/auth/refresh_token_response.dart';
import 'package:my_instrument/services/models/user.dart';
import 'package:my_instrument/shared/exceptions/uninitialized_exception.dart';
import 'package:my_instrument/shared/utils/parse_methods.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'future_response.dart';

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
    authService = AppInjector.get<AuthService>();
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
        throw UninitializedException(CallerClass.SharedPreferences);
      }
      var response = await authService.login(LoginRequest(email: email, password: password));

      if (response.OK) {
        _user = (response as LoginResponse).applicationUser;

        if (rememberMe == true) {
          await prefs?.setBool('signedIn', true);
          await saveUserToPrefs();
        }
      } else {
        if (response.StatusCode == 409) {
          await signOut();
        }

        return FutureResponse(exception: response.Message);
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

      if (!response.OK) {
        return FutureResponse(exception: response.Message);
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

      if (response.OK) {
        response = response as RefreshTokenResponse;
        statusCode = response.StatusCode;

        if (response.StatusCode != 1001) {
          _user?.token = response.Token;
          _user?.tokenExpires = response.TokenExpires;
          _user?.refreshToken = response.RefreshToken;
          _user?.refreshTokenExpires = response.RefreshTokenExpires;
          await saveUserToPrefs();
        }
      } else {
        if (response.StatusCode == 404 || response.StatusCode == 409) {
          await signOut();
        }

        return FutureResponse(exception: response.Message);
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
      await prefs?.setString('token', _user?.token ?? '');
      await prefs?.setString('user', jsonEncode(_user));
      await prefs?.setBool('signedIn', true);
    }
  }
}