import 'dart:async';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_instrument/services/http_service.dart';
import 'package:my_instrument/services/models/responses/base_response.dart'
    as MyBaseResponse;
import 'package:my_instrument/services/models/responses/main/profile/profile_constants.dart';
import 'package:my_instrument/services/models/responses/main/profile/profile_response.dart';

class ProfileService extends HttpService {
  // static ProfileService instance = ProfileService();

  Future<MyBaseResponse.BaseResponse> getProfile(int id) async {
    if (await model.ensureAuthorized()) {
      Response res =
          await getData(ProfileConstants.GetPublicProfile + "$id");

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        ProfileResponse profileResponse = ProfileResponse(body);
        return profileResponse;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }


  Future<MyBaseResponse.BaseResponse> getMyProfile() async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(ProfileConstants.GetMyProfile);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        ProfileResponse profileResponse = ProfileResponse(body);
        return profileResponse;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }

}