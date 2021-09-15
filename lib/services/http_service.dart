import 'dart:convert';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/auth_model.dart';
import 'models/requests/backend_request.dart';

class HttpService {
  final String LocalApiUrl = "https://myinstrument.conveyor.cloud/api/";
  final String ProductionApiUrl = "";
  late final AuthModel model;
  late final SharedPreferences prefs;
  HttpService() {
    this.model = Modular.get<AuthModel>();
    init();
  }

  void init() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  get ApiUrl {
    if (Foundation.kReleaseMode) {
      return ProductionApiUrl;
    }
    return LocalApiUrl;
  }

  postJson(BackendRequest data, String path, ) {
    return post(
      Uri.parse(ApiUrl + path),
      body: jsonEncode(data.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    });
  }

  getData(String path) {
    String? bearerToken = prefs.getString('token');
    return get(
      Uri.parse(ApiUrl + path),
      headers: {
        'Authorization': bearerToken != null ? 'Bearer ${bearerToken}' : ''
      }
    );
  }
}