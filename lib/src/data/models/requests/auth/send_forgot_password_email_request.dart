import 'package:my_instrument/src/data/models/requests/backend_request.dart';

class SendForgotPasswordEmailRequest implements BackendRequest {
  final String email;

  const SendForgotPasswordEmailRequest({
    required this.email
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email
    };
  }
}