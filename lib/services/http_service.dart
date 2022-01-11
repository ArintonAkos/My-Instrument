import 'dart:convert';

import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import 'package:injector/injector.dart';
import 'package:my_instrument/src/data/models/requests/backend_request.dart';
import 'package:my_instrument/src/data/models/requests/multipart_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/auth_model.dart';

class HttpService {
  static const String _localUrl = "https://myinstrument.conveyor.cloud/";
  static const String _localRemoteUrl = "https://myinstrument.conveyor.cloud/";
  static const String _productionUrl = "";
  static const String _productionRemoteUrl = "";
  final _injector = Injector.appInstance;

  late final AuthModel model;
  late final SharedPreferences prefs;

  HttpService() {
    model = _injector.get<AuthModel>();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static get basicUrl {
    if (foundation.kReleaseMode) {
      return _productionUrl;
    }
    return _localUrl;
  }

  static get apiUrl {
    if (foundation.kReleaseMode) {
      return _productionUrl + 'api/';
    }
    return _localUrl + 'api/';
  }

  static get hubUrl {
    if (foundation.kReleaseMode) {
      return _productionRemoteUrl + 'hubs/chat';
    }
    return _localRemoteUrl + 'hubs/chat';
  }

  Future<http.Response> postJson(BackendRequest data, String path, )  async {
    String? bearerToken = prefs.getString('token');
    return http.post(
      Uri.parse(apiUrl + path),
      body: jsonEncode(data.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
    });
  }

  Future<http.Response> getData(String path) {
    String? bearerToken = prefs.getString('token');
    return http.get(
      Uri.parse(apiUrl + path),
      headers: {
        'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
      }
    );
  }

  Future<http.StreamedResponse> postMultipart(MultipartRequest data, String path) async {
    String? bearerToken = prefs.getString('token');
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(apiUrl + path)
    )
      ..headers.addAll({
        'Authorization': bearerToken != null ? 'Bearer $bearerToken' : '',
        'X-Requested-With': 'XMLHttpRequest'
      })
      ..fields.addAll(data.toJson());

    var imagePaths = data.getImagePaths();
    int i = 0;
    for (var element in imagePaths) {
      var multipartFile = await http.MultipartFile.fromPath('file-$i', element);
      request.files.add(multipartFile);
      i++;
    }

    return request.send();
  }

  Future<http.Response> putData(String path) async {
    String? bearerToken = prefs.getString('token');
    return http.put(
      Uri.parse(apiUrl + path),
      headers: {
        'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
      }
    );
  }

  Future<http.Response> deleteData(String path) async {
    String? bearerToken = prefs.getString('token');
    return http.delete(
        Uri.parse(apiUrl + path),
        headers: {
          'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
        }
    );
  }
}