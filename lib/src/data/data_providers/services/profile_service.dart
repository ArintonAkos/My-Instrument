import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/data_providers/services/http_service.dart';
import 'package:my_instrument/src/data/models/requests/main/profile/add_rating_request.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/src/data/models/responses/main/profile/responses/base_profile_response.dart';
import 'package:my_instrument/src/data/data_providers/constants/profile_constants.dart';
import 'package:my_instrument/src/data/models/responses/main/profile/responses/get_profile_rating_response.dart';
import 'package:my_instrument/src/data/models/responses/main/profile/responses/profile_response.dart';

class ProfileService extends HttpService {
  ProfileService({ required AppLanguage appLanguage}) : super(appLanguage: appLanguage);

  Future<my_base_response.BaseResponse> getProfile(String id) async {
    if (await model.ensureAuthorized()) {
      Response res =
      await getData(ProfileConstants.getPublicProfile + id, concat: true);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        ProfileResponse profileResponse = ProfileResponse(body, appLanguage);
        return profileResponse;
      }
    }
    return my_base_response.BaseResponse.error(appLanguage);
  }

  Future<my_base_response.BaseResponse> getBaseProfile(String id) async {
    if (await model.ensureAuthorized()) {
      Response res =
      await getData(ProfileConstants.getBaseProfile + id, concat: true);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        BaseProfileResponse baseProfileResponse = BaseProfileResponse(body, appLanguage);
        return baseProfileResponse;
      }
    }
    return my_base_response.BaseResponse.error(appLanguage);
  }

  Future<my_base_response.BaseResponse> getMyProfile() async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(ProfileConstants.getMyProfile);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        ProfileResponse profileResponse = ProfileResponse(body, appLanguage);
        return profileResponse;
      }
    }
    return my_base_response.BaseResponse.error(appLanguage);
  }

  /// Gets all of the ratings associated with the provided user ID.
  ///
  /// The [userId] is the ID of the user.
  Future<my_base_response.BaseResponse> getProfileRatings(String id) async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(ProfileConstants.profileRatingWithUserId + id, concat: true);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        GetProfileRatingResponse response = GetProfileRatingResponse(body, appLanguage);
        return response;
      }
    }

    return my_base_response.BaseResponse.error(appLanguage);
  }

  /// Create a profile rating associated with provided user ID.
  ///
  /// The [request] parameter contains the needed info for creating a new profile rating.
  Future<my_base_response.BaseResponse> addProfileRating(AddRatingRequest request) async {
    if (await model.ensureAuthorized()) {
      Response res = await postJson(request, ProfileConstants.profileRating);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        my_base_response.BaseResponse response = my_base_response.BaseResponse(body, appLanguage);
        return response;
      }
    }

    return my_base_response.BaseResponse.error(appLanguage);
  }

  /// Deletes the profile rating associated with the provided user ID.
  ///
  /// The [userId] is the ID of the user.
  Future<my_base_response.BaseResponse> deleteProfileRating(String userId) async {
    if (await model.ensureAuthorized()) {
      Response res = await deleteData(ProfileConstants.profileRatingWithUserId + userId, concat: true);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        my_base_response.BaseResponse response = my_base_response.BaseResponse(body, appLanguage);
        return response;
      }
    }

    return my_base_response.BaseResponse.error(appLanguage);
  }
}
