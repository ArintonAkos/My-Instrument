import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/services/http_service.dart';
import 'package:my_instrument/services/models/requests/main/message/message_request.dart';
import 'package:my_instrument/services/models/responses/base_response.dart'
as MyBaseResponse;

import 'package:my_instrument/services/models/responses/main/message/message_constants.dart';
import 'package:my_instrument/services/models/responses/main/message/message_response.dart';

class MessageService extends HttpService {
  static MessageService instance = MessageService();

  Future<MyBaseResponse.BaseResponse> getMessageList() async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(MessageConstants.GetMessageList);
      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        MessageResponse messageResponse = MessageResponse(body);
        return messageResponse;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }

  Future<MyBaseResponse.BaseResponse> getMessages(String userId) async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(MessageConstants.GetMessages + userId);
      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        MessageResponse messageResponse = MessageResponse(body);
        return messageResponse;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }

  Future<MyBaseResponse.BaseResponse> sendMessage(SendMessageRequest data) async {
    if (await model.ensureAuthorized()) {
      Response res = await postJson(data, MessageConstants.SendMessage);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        MyBaseResponse.BaseResponse registerResponse = MyBaseResponse.BaseResponse(body);
        return registerResponse;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }
}