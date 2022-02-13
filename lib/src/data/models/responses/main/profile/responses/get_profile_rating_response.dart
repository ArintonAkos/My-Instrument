import 'package:my_instrument/src/data/models/responses/base_response.dart';
import 'package:my_instrument/src/data/models/responses/main/profile/models/public_rating_model.dart';

import '../../../../../../shared/utils/list_parser.dart';
import '../../../../../data_providers/change_notifiers/app_language.dart';

class GetProfileRatingResponse extends BaseResponse {
  late final List<PublicRatingModel> ratings;

  GetProfileRatingResponse(Map<String, dynamic> json, AppLanguage appLanguage) : super(json, appLanguage) {
    ratings = ListParser.parse<PublicRatingModel>(json['ratings'], PublicRatingModel.fromJson);
  }
}