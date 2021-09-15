import 'dart:convert';

import 'package:my_instrument/shared/utils/parsable_date_time.dart';
import 'package:my_instrument/shared/utils/parse_methods.dart';

import 'settings.dart';

class User {
  User({
    required this.Email,
    required this.Name,
    required this.Roles,
    required this.Ratings,
    required this.Setting,
    required this.TokenExpires,
    required this.RefreshTokenExpires,
    required this.Token,
    required this.RefreshToken
  });

  final String Email;
  final String Name;
  final List<String> Roles;
  final List<String> Ratings;
  final Settings Setting;
  ParsableDateTime? TokenExpires;
  ParsableDateTime? RefreshTokenExpires;
  String Token;
  String RefreshToken;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      Email: json['email'] ?? '',
      Name: json['name'] ?? '',
      Roles: ParseMethods.parseStringList(json['roles']),
      Ratings: ParseMethods.parseStringList(json['ratings']),
      Setting: Settings.fromJson(json['setting']),
      Token: json['token'] ?? '',
      RefreshToken: json['refreshToken'] ?? '',
      TokenExpires: ParsableDateTime.fromJson(json['tokenExpires']),
      RefreshTokenExpires: ParsableDateTime.fromJson(json['refreshTokenExpires'])
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': this.Email,
      'name': this.Name,
      'roles': this.Roles,
      'ratings': this.Ratings,
      'setting': this.Setting,
      'tokenExpires': this.TokenExpires,
      'refreshTokenExpires': this.RefreshTokenExpires,
      'token': this.Token,
      'refreshToken': this.RefreshToken
    };
  }


}