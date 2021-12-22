import 'package:my_instrument/services/models/responses/base_response.dart';
import 'package:my_instrument/shared/utils/list_parser.dart';

import 'message_model.dart';

class MessageResponse extends BaseResponse {
  late final List<MessageModel> messageList;

  MessageResponse(Map<String, dynamic> json) : super(json) {
    messageList = ListParser.parse<MessageModel>(json['messages'], MessageModel.fromJson);
  }
}