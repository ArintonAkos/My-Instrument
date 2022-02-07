import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/shared/utils/list_parser.dart';

import '../../base_response.dart';
import 'chat_message_model.dart';

class ChatMessageResponse extends BaseResponse {
  late final List<ChatMessageModel> messageList;

  ChatMessageResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    messageList = ListParser.parse<ChatMessageModel>(json['messages'], ChatMessageModel.fromJson);
  }
}