import 'dart:convert';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injector/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/auth_model.dart';
import 'models/requests/backend_request.dart';
import 'models/requests/multipart_request.dart' as multipart_request;

class HttpService {
  static const String _LocalUrl = "https://myinstrument.conveyor.cloud/";
  static const String _LocalRemoteUrl = "https://myinstrument.conveyor.cloud/";
  static const String _ProductionUrl = "";
  static const String _ProductionRemoteUrl = "";
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

  static get BasicUrl {
    if (Foundation.kReleaseMode) {
      return _ProductionUrl;
    }
    return _LocalUrl;
  }

  static get ApiUrl {
    if (Foundation.kReleaseMode) {
      return _ProductionUrl + 'api/';
    }
    return _LocalUrl + 'api/';
  }

  static get HubUrl {
    if (Foundation.kReleaseMode) {
      return _ProductionRemoteUrl + 'hubs/chat';
    }
    return _LocalRemoteUrl + 'hubs/chat';
  }

  Future<http.Response> postJson(BackendRequest data, String path, )  async {
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

  Future<http.Response> getData(String path) {
    String? bearerToken = prefs.getString('token');
    return http.get(
      Uri.parse(ApiUrl + path),
      headers: {
        'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
      }
    );
  }

  Future<http.StreamedResponse> postMultipart(multipart_request.MultipartRequest data, String path) async {
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
    for (var element in imagePaths) {
      var multipartFile = await http.MultipartFile.fromPath('file-$i', element);
      request.files.add(multipartFile);
      i++;
    }

    return request.send();
  }

  Future<http.Response> deleteData(String path) async {
    String? bearerToken = prefs.getString('token');
    return http.delete(
        Uri.parse(ApiUrl + path),
        headers: {
          'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
        }
    );
  }
}