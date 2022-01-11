import 'package:my_instrument/src/data/models/repository_models/user.dart';

import '../base_response.dart';

class LoginResponse extends BaseResponse {
  late final User applicationUser;

  LoginResponse(Map<String, dynamic> json) : super(json) {
    applicationUser = User.fromJson(json);
  }
}