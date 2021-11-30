import 'dart:convert';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/auth_model.dart';
import 'models/requests/backend_request.dart';
import 'models/requests/multipart_request.dart';

class HttpService {
  static const String LocalApiUrl = "https://myinstrument.conveyor.cloud/api/";
  static const String ProductionApiUrl = "";
  late final AuthModel model;
  late final SharedPreferences prefs;

  HttpService() {
    model = Modular.get<AuthModel>();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static get ApiUrl {
    if (Foundation.kReleaseMode) {
      return ProductionApiUrl;
    }
    return LocalApiUrl;
  }

  postJson(BackendRequest data, String path, ) {
    String? bearerToken = prefs.getString('token');
    return http.post(
      Uri.parse(ApiUrl + path),
      body: jsonEncode(data.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
    });
  }

  getData(String path) {
    String? bearerToken = prefs.getString('token');
    return http.get(
      Uri.parse(ApiUrl + path),
      headers: {
        'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
      }
    );
  }
  
  postMultipart(MultipartRequest data, String path) async {
    String? bearerToken = prefs.getString('token');
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiUrl + path)
    )
      ..headers.addAll({
        'Authorization': bearerToken != null ? 'Bearer $bearerToken' : '',
        'X-Requested-With': 'XMLHttpRequest'
      })
      ..fields.addAll(data.toJson());

    var imagePaths = data.getImagePaths();
    int i = 0;
    imagePaths.forEach((element) async {
      var multipartFile = await http.MultipartFile.fromPath('file-$i', element);
      request.files.add(multipartFile);
      i++;
    });

    return request.send();
  }

  deleteData(String path) {
    String? bearerToken = prefs.getString('token');
    return http.delete(
        Uri.parse(ApiUrl + path),
        headers: {
          'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
        }
    );
  }
}