import 'package:my_instrument/services/models/responses/base_response.dart';
import 'package:my_instrument/services/models/responses/error_response.dart';

import 'message_model.dart';

class MessageResponse extends BaseResponse {
  late final List<MessageModel> messageList;


  MessageResponse(Map<String, dynamic> json) : super(json) {
    messageList = parseMessage(json);
  }

  List<MessageModel> parseMessage(Map<String, dynamic> json) {
    dynamic data = json['data'];

    if (data != null) {
      var list = data['messages'] as List;
      List<MessageModel> messages = list.map((e) =>
          MessageModel(json: e)
      ).toList();

      return messages;
    }

    return List.empty();
  }

  factory MessageResponse.errorMessage({int language = 0}) {
    return MessageResponse(ErrorResponse(language: language).ResponseJSON);
  }
}