import 'package:my_instrument/shared/utils/parsable_date_time.dart';
import 'package:my_instrument/shared/utils/parse_methods.dart';

import 'settings.dart';

enum AuthenticationType {
  email,
  google,
  facebook
}

class User {
  User({
    required this.email,
    required this.name,
    required this.userId,
    required this.roles,
    required this.ratings,
    required this.setting,
    required this.tokenExpires,
    required this.refreshTokenExpires,
    required this.token,
    required this.refreshToken,
    required this.authenticationType
  });

  final String email;
  final String name;
  final String userId;
  final List<String> roles;
  final List<String> ratings;
  final Settings setting;
  final AuthenticationType authenticationType;
  ParsableDateTime? tokenExpires;
  ParsableDateTime? refreshTokenExpires;
  String token;
  String refreshToken;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      userId: json['userId'] ?? '',
      roles: ParseMethods.parseStringList(json['roles']),
      ratings: ParseMethods.parseStringList(json['ratings']),
      setting: Settings.fromJson(json['setting']),
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      authenticationType: parseAuthenticationType(json['authenticationType']),
      tokenExpires: ParsableDateTime.fromString(json['tokenExpires'], toLocale: false),
      refreshTokenExpires: ParsableDateTime.fromString(json['refreshTokenExpires'], toLocale: false)
    );
  }

  static AuthenticationType parseAuthenticationType(String? authenticationType) {
    try {
      AuthenticationType type = AuthenticationType.values.byName(authenticationType ?? '');
      return type;
    } catch (e) {
      return AuthenticationType.email;
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'userId': userId,
      'roles': roles,
      'ratings': ratings,
      'setting': setting,
      'tokenExpires': tokenExpires,
      'refreshTokenExpires': refreshTokenExpires,
      'token': token,
      'refreshToken': refreshToken,
      'authenticationType': authenticationType.toString(),
    };
  }
}