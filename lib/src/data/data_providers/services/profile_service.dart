import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/src/data/data_providers/services/http_service.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/src/data/models/responses/main/profile/base_profile_response.dart';
import 'package:my_instrument/src/data/data_providers/constants/profile_constants.dart';
import 'package:my_instrument/src/data/models/responses/main/profile/profile_response.dart';

class ProfileService extends HttpService {

  Future<my_base_response.BaseResponse> getProfile(String id) async {
    if (await model.ensureAuthorized()) {
      Response res =
      await getData(ProfileConstants.getPublicProfile + id);

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
      await getData(ProfileConstants.getBaseProfile + id);

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
      Response res = await getData(ProfileConstants.getMyProfile);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        ProfileResponse profileResponse = ProfileResponse(body);
        return profileResponse;
      }
    }
    return my_base_response.BaseResponse.error();
  }

}
