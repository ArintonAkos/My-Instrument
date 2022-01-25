import '../../base_response.dart';
import '../../../../../shared/utils/list_parser.dart';
import 'chat_message_model.dart';

class ChatMessageResponse extends BaseResponse {
  late final List<ChatMessageModel> messageList;

  ChatMessageResponse(Map<String, dynamic> json) : super(json) {
    messageList = ListParser.parse<ChatMessageModel>(json['messages'], ChatMessageModel.fromJson);
  }
}