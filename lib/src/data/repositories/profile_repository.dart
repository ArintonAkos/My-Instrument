import 'package:my_instrument/src/data/data_providers/services/profile_service.dart';
import 'package:my_instrument/src/data/models/requests/main/profile/add_rating_request.dart';
import 'package:my_instrument/src/data/models/responses/main/profile/models/public_rating_model.dart';
import 'package:my_instrument/src/data/models/responses/main/profile/responses/base_profile_response.dart';
import 'package:my_instrument/src/data/models/responses/main/profile/responses/get_profile_rating_response.dart';

import '../../../structure/dependency_injection/injector_initializer.dart';
import '../models/responses/main/profile/models/profile_model.dart';
import '../models/responses/main/profile/responses/profile_response.dart';

class ProfileRepository {
  final ProfileService _profileService = appInjector.get<ProfileService>();

  /// Gets info about the user associated with the user ID.
  ///
  /// The [userId] is the Id of the user.
  Future<ProfileModel> getProfile(String userId) async {
    var res = await _profileService.getProfile(userId);

    if (res.ok) {
      return (res as ProfileResponse).data;
    }

    throw Exception(res.message);
  }

  /// Gets the basic info about the user associated with the user ID.
  ///
  /// The [userId] is the Id of the user.
  Future<BaseProfileModel> getBaseProfile(String userId) async {
    var res = await _profileService.getBaseProfile(userId);

    if (res.ok) {
      return (res as BaseProfileResponse).data;
    }

    throw Exception(res.message);
  }

  /// Gets info about the current user.
  Future<ProfileModel> getMyProfile() async {
    var res = await _profileService.getMyProfile();

    if (res.ok) {
      return (res as ProfileResponse).data;
    }

    throw Exception(res.message);
  }

  /// Returns a list containing the ratings associated with the provided user ID.
  ///
  /// The [userId] is the Id of the user.
  Future<List<PublicRatingModel>> getRatings(String userId) async {
    var res = await _profileService.getProfileRatings(userId);

    if (res.ok) {
      return (res as GetProfileRatingResponse).ratings;
    }

    throw Exception(res.message);
  }

  /// Returns whether or not the operation was successful.
  Future<bool> addProfileRating(AddRatingRequest ratingRequest) async {
    var res = await _profileService.addProfileRating(ratingRequest);

    if (res.ok) {
      return true;
    }

    throw Exception(res.message);
  }

  /// Returns whether or not the operation was successful.
  Future<bool> removeProfileRating(String userId) async {
    var res = await _profileService.deleteProfileRating(userId);

    if (res.ok) {
      return true;
    }

    throw Exception(res.message);
  }
}