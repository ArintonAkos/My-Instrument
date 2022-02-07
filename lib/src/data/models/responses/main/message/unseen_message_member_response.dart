
import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/shared/utils/list_parser.dart';
import 'package:my_instrument/src/data/models/responses/main/message/unseen_message_member_model.dart';

import '../../base_response.dart';

class UnseenMessageMemberResponse extends BaseResponse {
  late final List<UnseenMessageMemberModel> unseenMessageMembers;

  UnseenMessageMemberResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    unseenMessageMembers = ListParser.parse<UnseenMessageMemberModel>(json['unseenMessageMembers'], UnseenMessageMemberModel.fromJson);
  }
}