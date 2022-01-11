import '../backend_request.dart';

class RegisterRequest implements BackendRequest {
  final String email;
  final String password;
  String? firstName;
  String? lastName;
  String? companyName;
  final int accountType;
  final int themeMode;
  final int language;

  RegisterRequest({
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
    this.companyName,
    required this.accountType,
    this.themeMode = 0,
    this.language = 0
  });

  @override
  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'firstName': firstName ?? '',
    'lastName': lastName ?? '',
    'companyName': companyName ?? '',
    'accountType': accountType.toString(),
    'themeMode': themeMode.toString(),
    'language': language.toString(),
  };
}