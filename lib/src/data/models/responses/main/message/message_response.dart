import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/shared/utils/list_parser.dart';

import '../../base_response.dart';
import 'message_model.dart';

class MessageResponse extends BaseResponse {
  late final List<MessageModel> messageList;

  MessageResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    messageList = ListParser.parse<MessageModel>(json['messages'], MessageModel.fromJson);
  }
}