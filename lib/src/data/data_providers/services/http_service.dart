import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:injector/injector.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/data_providers/services/shared_prefs.dart';
import 'package:my_instrument/src/data/models/requests/backend_request.dart';
import 'package:my_instrument/src/data/models/requests/multipart_request.dart';

import '../change_notifiers/auth_model.dart';
import 'package:path/path.dart' as p;

class CustomTimeoutException extends TimeoutException {
  final int statusCode;
  CustomTimeoutException(String? message, this.statusCode) : super(message);
}

extension on Future {
  Future defaultTimeOut() {
    return timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw CustomTimeoutException("No response from server!", 404);
      }
    );
  }
}

class HttpService {
  static const String _localUrl = "https://192.168.1.155:3000/";
  static const String _localRemoteUrl = "https://192.168.1.155:3000/";

  static const String _productionUrl = "";
  static const String _productionRemoteUrl = "";

  final _injector = Injector.appInstance;
  final AppLanguage appLanguage;

  late final AuthModel model;

  HttpService({
    required this.appLanguage
  }) {
    model = _injector.get<AuthModel>();
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

  String getChainOperator(bool concat) {
    if (concat) {
      return '&';
    }

    return '?';
  }

  Future<http.Response> postJson(BackendRequest data, String path, { bool concat = false })  async {
    String? bearerToken = SharedPrefs.instance.getString('token');
    return await http.post(
      Uri.parse(apiUrl + path + getChainOperator(concat) + 'language=${appLanguage.localeIndex}'),
      body: jsonEncode(data.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
    }).defaultTimeOut();
  }

  Future<http.Response> getData(String path, { bool concat = false }) async {
    String? bearerToken = SharedPrefs.instance.getString('token');
    return await http.get(
      Uri.parse(apiUrl + path + getChainOperator(concat) + 'language=${appLanguage.localeIndex}'),
      headers: {
        'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
      }
    ).defaultTimeOut();
  }

  Future<http.StreamedResponse> postMultipart(MultipartRequest data, String path, { bool concat = false }) async {
    String? bearerToken = SharedPrefs.instance.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(apiUrl + path)
    );

    request.fields.addAll(data.toJson());

    var imagePaths = data.getImagePaths();
    for (var imagePath in imagePaths) {
      String? fileType = _getImageType(_getFileType(imagePath));
      if (fileType != null) {
        request.files.add(await http.MultipartFile.fromPath('images', imagePath,
          contentType: MediaType.parse(fileType)
        ));
      }
    }

    request.headers.addAll({
      'Authorization': bearerToken != null ? 'Bearer $bearerToken' : '',
    });

    return await request.send().defaultTimeOut();
  }



  Future<http.Response> putData(String path, { bool concat = false }) async {
    String? bearerToken = SharedPrefs.instance.getString('token');
    return await http.put(
      Uri.parse(apiUrl + path + getChainOperator(concat) + 'language=${appLanguage.localeIndex}'),
      headers: {
        'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
      }
    ).defaultTimeOut();
  }

  Future<http.Response> deleteData(String path, { bool concat = false }) async {
    String? bearerToken = SharedPrefs.instance.getString('token');
    return await http.delete(
        Uri.parse(apiUrl + path + getChainOperator(concat) + 'language=${appLanguage.localeIndex}'),
        headers: {
          'Authorization': bearerToken != null ? 'Bearer $bearerToken' : ''
        }
    ).defaultTimeOut();
  }

  Map<String, dynamic> decodeBody(String body) {
    try {
      return jsonDecode(body);
    } catch (e) {
      return <String, dynamic>{};
    }
  }

  String _getFileType(String filePath) {
    return p.extension(filePath);
  }

  String? _getImageType(String? extension) {
    const defaultTypeStr = 'image/';

    switch (extension) {
      case '.gif':
        return defaultTypeStr + 'gif';
      case '.jpg':
        return defaultTypeStr + 'jpeg';
      case '.jpeg':
        return defaultTypeStr + 'jpeg';
      case '.png':
        return defaultTypeStr + 'png';
    }

    return null;
  }
}