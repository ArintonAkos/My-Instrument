import 'package:my_instrument/src/data/data_providers/services/manage_user_service.dart';
import 'package:my_instrument/src/data/models/requests/auth/change_password_request.dart';
import 'package:my_instrument/src/data/models/requests/auth/confirm_email_request.dart';
import 'package:my_instrument/src/data/models/requests/auth/resend_email_confirmation_request.dart';
import 'package:my_instrument/src/data/models/requests/auth/send_forgot_password_email_request.dart';
import 'package:my_instrument/src/data/models/requests/auth/validate_pin_request.dart';
import 'package:my_instrument/src/data/models/responses/auth/confirm_email_response.dart';
import 'package:my_instrument/src/data/models/responses/auth/pin_validated_response.dart';
import 'package:my_instrument/src/data/models/responses/auth/resend_email_confirmation_response.dart';
import 'package:my_instrument/src/data/models/responses/auth/send_forgot_password_email_response.dart';
import 'package:my_instrument/src/data/models/responses/auth/validate_pin_response.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';

/// The base class for managing user settings like changing
/// the password email, or sending the email confirmation.
class ManageUserRepository {
  final ManageUserService _manageUserService = appInjector.get<ManageUserService>();

  /// Returns the confirm email id, which will be used in the request to validate pin,
  /// which the user received in email.
  Future<String> resendEmailConfirmation(ResendEmailConfirmationRequest request) async {
    var res = await _manageUserService.resendEmailConfirmation(request);

    if (res.ok) {
      return (res as ResendEmailConfirmationResponse).confirmEmailId;
    }

    throw Exception(res.message);
  }

  /// Returns whether the confirmation was successful or not.
  /// If it was not successful, it returns the remaining tries.
  Future<ConfirmEmail> confirmEmail(ConfirmEmailRequest request) async {
    var res = await _manageUserService.confirmEmail(request);

    if (res.statusCode == 200) {
      return const ConfirmEmail(
        ok: true,
        remainingTries: -1
      );
    } else if (res.statusCode == 409) {
      return ConfirmEmail(
        ok: false,
        remainingTries: (request as ConfirmEmailResponse).remainingTries
      );
    }

    throw Exception(res.message);
  }

  /// Returns the reset password id, which will be used in the request to validate pin,
  /// which the user received in email.
  Future<String> sendForgotPasswordEmail(SendForgotPasswordEmailRequest request) async {
    var res = await _manageUserService.sendForgotPasswordEmail(request);

    if (res.ok) {
      return (res as SendForgotPasswordEmailResponse).resetPasswordId;
    }

    throw Exception(res.message);
  }

  /// If the validation was successful it returns the token which is used for
  /// setting the new password.
  /// If it was not successful it returns the remaining tries.
  Future<ValidatePin> validatePin(ValidatePinRequest request) async {
    var res = await _manageUserService.validatePin(request);

    if (res.statusCode == 200) {
      return ValidatePin(
        ok: true,
        token: (res as PinValidatedResponse).token
      );
    } else if (res.statusCode == 409) {
      return ValidatePin(
        ok: false,
        remainingTries: (res as ValidatePinResponse).remainingTries
      );
    }

    throw Exception(res.message);
  }

  /// Returns whether the password change went successful or not.
  Future<bool> changePassword(ChangePasswordRequest request) async {
    var res = await _manageUserService.changePassword(request);

    if (res.ok) {
      return true;
    }

    throw Exception(res.message);
  }

}

class ConfirmEmail {
  final bool ok;
  final int remainingTries;

  const ConfirmEmail({
    required this.ok,
    required this.remainingTries
  });
}

class ValidatePin {
  final bool ok;
  final String? token;
  final int? remainingTries;

  const ValidatePin({
    required this.ok,
    this.remainingTries,
    this.token
  });
}