import 'package:my_instrument/src/data/models/requests/backend_request.dart';

class ResendEmailConfirmationRequest implements BackendRequest {
  final String emailAddress;

  const ResendEmailConfirmationRequest({
    required this.emailAddress
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': emailAddress
    };
  }
}