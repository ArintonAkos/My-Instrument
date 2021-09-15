import 'package:my_instrument/services/models/requests/backend_request.dart';

class RefreshTokenRequest implements BackendRequest {
  final String token;
  final String refreshToken;
  final int language;

  RefreshTokenRequest({
    required this.token,
    required this.refreshToken,
    this.language = 0
  }) {}

  @override
  Map<String, dynamic> toJson() => {
    'token': token,
    'refreshToken': refreshToken,
    'language': language.toString()
  };
}