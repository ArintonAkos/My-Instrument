import 'package:my_instrument/src/shared/utils/list_parser.dart';

import '../../base_response.dart';
import 'message_model.dart';

class MessageResponse extends BaseResponse {
  late final List<MessageModel> messageList;

  MessageResponse(Map<String, dynamic> json) : super(json) {
    messageList = ListParser.parse<MessageModel>(json['messages'], MessageModel.fromJson);
  }
}