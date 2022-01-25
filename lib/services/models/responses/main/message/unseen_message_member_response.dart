import 'package:my_instrument/services/models/responses/base_response.dart';
import 'package:my_instrument/services/models/responses/main/message/unseen_message_member_model.dart';

import '../../../../../shared/utils/list_parser.dart';

class UnseenMessageMemberResponse extends BaseResponse {
  late final List<UnseenMessageMemberModel> unseenMessageMembers;

  UnseenMessageMemberResponse(Map<String, dynamic> json) : super(json) {
    unseenMessageMembers = ListParser.parse<UnseenMessageMemberModel>(json['unseenMessageMembers'], UnseenMessageMemberModel.fromJson);
  }
}