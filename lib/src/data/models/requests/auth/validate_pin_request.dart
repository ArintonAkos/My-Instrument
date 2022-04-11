import 'package:my_instrument/src/data/models/requests/backend_request.dart';

class ValidatePinRequest implements BackendRequest {
  final String resetPasswordId;
  final String pin;

  const ValidatePinRequest({
    required this.resetPasswordId,
    required this.pin,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, String>{
      'resetPasswordId': resetPasswordId,
      'pin': pin,
    };
  }
}