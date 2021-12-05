import 'dart:convert';
import 'dart:core';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/bloc/main/i_auth_notifier.dart';
import 'package:my_instrument/services/auth/auth_service.dart';
import 'package:my_instrument/services/models/requests/auth/login_request.dart';
import 'package:my_instrument/services/models/requests/auth/refresh_token_request.dart';
import 'package:my_instrument/services/models/requests/auth/register_request.dart';
import 'package:my_instrument/services/models/responses/auth/login_response.dart';
import 'package:my_instrument/services/models/responses/auth/refresh_token_response.dart';
import 'package:my_instrument/services/models/user.dart';
import 'package:my_instrument/shared/exceptions/uninitialized_exception.dart';
import 'package:my_instrument/shared/utils/parsable_date_time.dart';
import 'package:my_instrument/shared/utils/parse_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'future_response.dart';

class AuthModel {
  User? _user;
  SharedPreferences? prefs;

  bool get isSignedIn {
    return (
        _user?.Token != null &&
        _user?.RefreshToken != null &&
        _user?.TokenExpires?.dateTime != null &&
        _user?.RefreshTokenExpires?.dateTime != null)
    ;
  }

  String? get userId {
    return _user?.Id;
  }

  late final AuthService authService;
  IAuthNotifier? authNotifier;

  Future init() async {
    authService = Modular.get<AuthService>();
    prefs = await SharedPreferences.getInstance();

    if (prefs?.getBool('signedIn') == true) {
      String? userPref = prefs?.getString('user');
      _user = ParseMethods.fromJsonString(userPref);

      if (_user?.Email != null) {
        var result = await ensureAuthorized();

        if (!result) {
          signOut();
        }
      } else {
        signOut();
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
        _user = (response as LoginResponse).ApplicationUser;
        if (rememberMe == true) {
          prefs?.setBool('signedIn', true);
          saveUserToPrefs();
        }
      } else {
        if (response.StatusCode == 409) {
          signOut();
        }
        return FutureResponse(exception: response.Message);
      }
    } catch (e) {
      return FutureResponse(exception: e);
    }

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
    try {
      var response = await authService.refreshToken(request);

      if (response.OK) {
        response = response as RefreshTokenResponse;
        if (response.StatusCode != 1001) {
          _user?.Token = response.Token;
          _user?.TokenExpires = response.TokenExpires;
          _user?.RefreshToken = response.RefreshToken;
          _user?.RefreshTokenExpires = response.RefreshTokenExpires;
          saveUserToPrefs();
        }
      } else {
        if (response.StatusCode == 409) {
          signOut();
        }
        return FutureResponse(exception: response.Message);
      }
    } catch (e) {
      return FutureResponse(exception: e);
    }

    return FutureResponse();
  }

  FutureResponse signOut() {
    prefs?.remove('signedIn');
    prefs?.remove('user');
    prefs?.remove('token');
    authNotifier?.onSignOut();
    return FutureResponse();
  }

  Future<bool> ensureAuthorized() async {
    if (_user?.TokenExpires?.dateTime == null || _user?.RefreshTokenExpires?.dateTime == null) {
      signOut();
      return false;
    }
    if (_user?.TokenExpires?.dateTime?.isBefore(DateTime.now().toUtc()) == true) {
      var token = _user?.Token ?? '';
      var refreshToken = _user?.RefreshToken ?? '';

      var result = await this.refreshToken(RefreshTokenRequest(
          token: token,
          refreshToken: refreshToken
      ));

      if (!result.success) {
        // signOut();
        return false;
      }
    }
    return true;
  }

  Future<String> getAccessToken() async {
    if (await ensureAuthorized()) {
      return _user?.Token ?? '';
    }

    return '';
  }

  setListener(IAuthNotifier authNotifier) {
    this.authNotifier = authNotifier;
  }

  removeListener() {
    authNotifier = null;
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

  saveUserToPrefs() {
    if (prefs != null && _user != null) {
      prefs?.setString('token', _user?.Token ?? '');
      prefs?.setString('user', jsonEncode(_user));
    }
  }
}