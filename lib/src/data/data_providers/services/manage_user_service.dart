import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/data_providers/services/http_service.dart';
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
import 'package:my_instrument/src/data/models/responses/base_response.dart' as my_base_response;

import '../constants/manage_user_constants.dart';

class ManageUserService extends HttpService {
  ManageUserService({
    required AppLanguage appLanguage
  }) : super(appLanguage: appLanguage);


  Future<my_base_response.BaseResponse> resendEmailConfirmation(ResendEmailConfirmationRequest request) async {
    Response res = await postJson(request, ManageUserConstants.resendEmailConfirmationUrl);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      ResendEmailConfirmationResponse response = ResendEmailConfirmationResponse(body, appLanguage);
      return response;
    }

    return my_base_response.BaseResponse.error(appLanguage);
  }

  Future<my_base_response.BaseResponse> confirmEmail(ConfirmEmailRequest request) async {
    Response res = await getData(ManageUserConstants.confirmEmailUrl + request.toString(), concat: true);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      body['statusCode'] = res.statusCode;

      my_base_response.BaseResponse response = my_base_response.BaseResponse(body, appLanguage);
      return response;
    } else if (res.statusCode == 409) {
      dynamic body = jsonDecode(res.body);
      body['statusCode'] = res.statusCode;

      ConfirmEmailResponse response = ConfirmEmailResponse(body, appLanguage);
      return response;
    }

    return my_base_response.BaseResponse.error(appLanguage);
  }

  Future<my_base_response.BaseResponse> sendForgotPasswordEmail(SendForgotPasswordEmailRequest request) async {
    Response res = await postJson(request, ManageUserConstants.sendForgotPasswordEmailUrl);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      SendForgotPasswordEmailResponse response = SendForgotPasswordEmailResponse(body, appLanguage);
      return response;
    }

    return my_base_response.BaseResponse.error(appLanguage);
  }

  Future<my_base_response.BaseResponse> validatePin(ValidatePinRequest request) async {
    Response res = await postJson(request, ManageUserConstants.validatePinUrl);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      body['statusCode'] = res.statusCode;

      PinValidatedResponse response = PinValidatedResponse(body, appLanguage);
      return response;
    } else  if (res.statusCode == 409) {
      dynamic body = jsonDecode(res.body);
      body['statusCode'] = res.statusCode;

      ValidatePinResponse response = ValidatePinResponse(body, appLanguage);
      return response;
    }

    return my_base_response.BaseResponse.error(appLanguage);
  }

  Future<my_base_response.BaseResponse> changePassword(ChangePasswordRequest request) async {
    Response res = await postJson(request, ManageUserConstants.changePasswordUrl);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      my_base_response.BaseResponse response = my_base_response.BaseResponse(body, appLanguage);
      return response;
    }

    return my_base_response.BaseResponse.error(appLanguage);
  }
}