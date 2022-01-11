import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/services/http_service.dart';
import 'package:my_instrument/src/data/models/requests/main/message/read_all_messages_request.dart';
import 'package:my_instrument/src/data/models/requests/main/message/send_message_request.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/src/data/models/responses/main/message/chat_message_response.dart';
import 'package:my_instrument/src/data/data_providers/constants/message_constants.dart';
import 'package:my_instrument/src/data/models/responses/main/message/message_response.dart';
import 'package:my_instrument/src/data/models/responses/main/message/unseen_message_member_response.dart';


class MessageService extends HttpService {
  Future<my_base_response.BaseResponse> getMessageList() async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(MessageConstants.getMessageList);
      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        MessageResponse messageResponse = MessageResponse(body);
        return messageResponse;
      }
    }
    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> getMessages(String userId, int page) async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(MessageConstants.getMessages + userId + '&page=$page');
      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        ChatMessageResponse chatMessageResponse = ChatMessageResponse(body);
        return chatMessageResponse;
      }
    }
    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> getUnseenMessageMembers() async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(MessageConstants.getUnseenMessageMembers);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        UnseenMessageMemberResponse response = UnseenMessageMemberResponse(body);
        return response;
      }
    }

    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> sendMessage(SendMessageRequest data) async {
    if (await model.ensureAuthorized()) {
      Response res = await postJson(data, MessageConstants.sendMessage);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        my_base_response.BaseResponse sendMessageResponse = my_base_response.BaseResponse(body);
        return sendMessageResponse;
      }
    }
    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> readAllMessages(ReadAllMessagesRequest request) async {
    if (await model.ensureAuthorized()) {
      Response res = await postJson(request, MessageConstants.readAllMessages);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        my_base_response.BaseResponse sendMessageResponse = my_base_response.BaseResponse(body);
        return sendMessageResponse;
      }
    }
    return my_base_response.BaseResponse.error();
  }
}