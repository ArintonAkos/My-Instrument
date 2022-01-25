import '../backend_request.dart';

class ExternalLoginRequest implements BackendRequest {

  final String loginProvider;
  final String providerKey;
  final String emailAddress;
  final String accessToken;
  final String? name;
  final String? firstName;
  final String? lastName;

  ExternalLoginRequest({
    required this.accessToken,
    required this.loginProvider,
    required this.providerKey,
    required this.emailAddress,
    this.name,
    this.firstName,
    this.lastName
  });

  @override
  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'emailAddress': emailAddress,
    'loginProvider': loginProvider,
    'providerKey': providerKey,
  };
}