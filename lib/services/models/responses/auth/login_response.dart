import 'package:my_instrument/services/models/responses/base_response.dart';

import '../../settings.dart';
import '../../user.dart';

class LoginResponse extends BaseResponse {
  late final User ApplicationUser;

  LoginResponse(Map<String, dynamic> json) : super(json) {
    ApplicationUser = User.fromJson(json);
  }
}