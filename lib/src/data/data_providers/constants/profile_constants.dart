class ProfileConstants {
  static const _profileUrl = 'Profile/';

  static const getPublicProfile = _profileUrl + 'PublicProfile?userId=';

  static const getBaseProfile = _profileUrl + 'BaseProfile?userId=';

  static const getMyProfile = _profileUrl + 'MyProfile';

  static const profileRating = _profileUrl + 'Rating';

  static const profileRatingWithUserId = profileRating + '?userId';
}