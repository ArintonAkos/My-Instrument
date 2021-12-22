import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/services/http_service.dart';
import 'package:my_instrument/services/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/services/models/responses/main/profile/base_profile_response.dart';
import 'package:my_instrument/services/models/responses/main/profile/profile_constants.dart';
import 'package:my_instrument/services/models/responses/main/profile/profile_response.dart';

class ProfileService extends HttpService {

  Future<my_base_response.BaseResponse> getProfile(String id) async {
    if (await model.ensureAuthorized()) {
      Response res =
      await getData(ProfileConstants.GetPublicProfile + id);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        ProfileResponse profileResponse = ProfileResponse(body);
        return profileResponse;
      }
    }
    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> getBaseProfile(String id) async {
    if (await model.ensureAuthorized()) {
      Response res =
      await getData(ProfileConstants.GetBaseProfile + id);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        BaseProfileResponse baseProfileResponse = BaseProfileResponse(body);
        return baseProfileResponse;
      }
    }
    return my_base_response.BaseResponse.error();
  }


  Future<my_base_response.BaseResponse> getMyProfile() async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(ProfileConstants.GetMyProfile);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        ProfileResponse profileResponse = ProfileResponse(body);
        return profileResponse;
      }
    }
    return my_base_response.BaseResponse.error();
  }

}
