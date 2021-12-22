import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/services/http_service.dart';
import 'package:my_instrument/services/models/requests/main/message/read_all_messages_request.dart';
import 'package:my_instrument/services/models/requests/main/message/send_message_request.dart';
import 'package:my_instrument/services/models/responses/base_response.dart'
as MyBaseResponse;
import 'package:my_instrument/services/models/responses/main/message/chat_message_response.dart';

import 'package:my_instrument/services/models/responses/main/message/message_constants.dart';
import 'package:my_instrument/services/models/responses/main/message/message_response.dart';
import 'package:my_instrument/services/models/responses/main/message/unseen_message_member_response.dart';

class MessageService extends HttpService {
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

  Future<MyBaseResponse.BaseResponse> getMessages(String userId, int page) async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(MessageConstants.GetMessages + userId + '&page=$page');
      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        ChatMessageResponse chatMessageResponse = ChatMessageResponse(body);
        return chatMessageResponse;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }

  Future<MyBaseResponse.BaseResponse> getUnseenMessageMembers() async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(MessageConstants.GetUnseenMessageMembers);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        UnseenMessageMemberResponse response = UnseenMessageMemberResponse(body);
        return response;
      }
    }

    return MyBaseResponse.BaseResponse.error();
  }

  Future<MyBaseResponse.BaseResponse> sendMessage(SendMessageRequest data) async {
    if (await model.ensureAuthorized()) {
      Response res = await postJson(data, MessageConstants.SendMessage);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        MyBaseResponse.BaseResponse sendMessageResponse = MyBaseResponse.BaseResponse(body);
        return sendMessageResponse;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }

  Future<MyBaseResponse.BaseResponse> readAllMessages(ReadAllMessagesRequest request) async {
    if (await model.ensureAuthorized()) {
      Response res = await postJson(request, MessageConstants.ReadAllMessages);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        MyBaseResponse.BaseResponse sendMessageResponse = MyBaseResponse.BaseResponse(body);
        return sendMessageResponse;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }
}