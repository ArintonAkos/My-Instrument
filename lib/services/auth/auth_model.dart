import 'dart:core';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/bloc/main/i_auth_notifier.dart';
import 'package:my_instrument/services/auth/auth_service.dart';
import 'package:my_instrument/services/models/requests/auth/login_request.dart';
import 'package:my_instrument/services/models/requests/auth/refresh_token_request.dart';
import 'package:my_instrument/services/models/requests/auth/register_request.dart';
import 'package:my_instrument/shared/exceptions/uninitialized_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'future_response.dart';

class AuthModel {
  SharedPreferences? prefs;
  String? userEmail;
  DateTime? tokenExpires;
  DateTime? refreshTokenExpires;
  bool get isSignedIn => !(userEmail?.isEmpty ?? true);
  late final AuthService authService;
  IAuthNotifier? authNotifier;

  Future init() async {
    authService = Modular.get<AuthService>();

    this.prefs = await SharedPreferences.getInstance();
    if (prefs?.getBool('signedIn') == true) {
      userEmail = await prefs?.getString('userEmail');
      refreshTokenExpires = tryParseInt(await prefs?.getInt('refreshTokenExpires'));
      tokenExpires = tryParseInt(await prefs?.getInt('tokenExpires'));
      if (userEmail != null) {
        var result = await ensureAuthorized();

        if (!result) {
          this.signOut();
        }
      } else {
        this.signOut();
      }
    }
  }

  Future<FutureResponse> signIn(String email, String password, { bool? rememberMe }) async {
    try {
      if (prefs == null) {
        throw new UninitializedException(CallerClass.SharedPreferences);
      }
      var response = await authService.login(LoginRequest(email: email, password: password));

      if (response.OK) {
        if (rememberMe == true) {
          this.prefs?.setBool('signedIn', true);
          this.prefs?.setString('userEmail', email);
          this.prefs?.setString('token', response.Token);
          this.prefs?.setString('refreshToken', response.RefreshToken);
          this.prefs?.setInt('tokenExpires', response.TokenExpires?.millisecondsSinceEpoch ?? -1);
          this.prefs?.setInt('refreshTokenExpires', response.RefreshTokenExpires?.millisecondsSinceEpoch ?? -1);
        }
        tokenExpires = response.TokenExpires;
        refreshTokenExpires = response.RefreshTokenExpires;
        userEmail = email;
      } else {
        if (response.StatusCode == 409) {
          this.signOut();
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
        if (response.StatusCode != 1001) {
          this.prefs?.setString('token', response.Token);
          this.prefs?.setString('refreshToken', response.RefreshToken);
          this.prefs?.setInt('tokenExpires', response.TokenExpires.millisecondsSinceEpoch);
          this.prefs?.setInt('refreshTokenExpires', response.RefreshTokenExpires.millisecondsSinceEpoch);
          tokenExpires = response.TokenExpires;
          refreshTokenExpires = response.RefreshTokenExpires;
        }
      } else {
        if (response.StatusCode == 409) {
          this.signOut();
        }
        return FutureResponse(exception: response.Message);
      }
    } catch (e) {
      return FutureResponse(exception: e);
    }

    return FutureResponse();
  }

  FutureResponse signOut() {
    userEmail = null;
    tokenExpires = null;
    refreshTokenExpires = null;
    prefs?.remove('signedIn');
    prefs?.remove('userEmail');
    prefs?.remove('token');
    prefs?.remove('refreshToken');
    prefs?.remove('tokenExpires');
    prefs?.remove('refreshTokenExpires');
    authNotifier?.onSignOut();
    return FutureResponse();
  }

  Future<bool> ensureAuthorized() async {
    if (tokenExpires == null || refreshTokenExpires == null) {
      this.signOut();
      return false;
    }
    if (tokenExpires?.isBefore(DateTime.now().toUtc()) == true) {
      var token = this.prefs?.getString('token') ?? '';
      var refreshToken = this.prefs?.getString('refreshToken') ?? '';

      var result = await this.refreshToken(RefreshTokenRequest(
          token: token,
          refreshToken: refreshToken
      ));

      if (!result.success) {
        return false;
      }
    }
    return true;
  }

  setListener(IAuthNotifier authNotifier) {
    this.authNotifier = authNotifier;
  }

  removeListener() {
    this.authNotifier = null;
  }

  DateTime? tryParseInt(int? timeStamp) {
    if (timeStamp == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(timeStamp, isUtc: true);
  }
}