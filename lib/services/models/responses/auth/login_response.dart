import 'package:my_instrument/services/models/responses/base_response.dart';

import '../../user.dart';

class LoginResponse extends BaseResponse {
  late final User applicationUser;

  LoginResponse(Map<String, dynamic> json) : super(json) {
    applicationUser = User.fromJson(json);
  }
}