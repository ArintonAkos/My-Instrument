import 'package:my_instrument/src/data/models/view_models/cart_item_data.dart';
import 'package:my_instrument/src/shared/utils/list_parser.dart';

import '../../base_response.dart';

class GetCartItemsResponse extends BaseResponse {
  late final List<CartItemData> cartItems;

  GetCartItemsResponse(Map<String, dynamic> json) : super(json) {
    cartItems = ListParser.parse(json['items'], CartItemData.fromJson);
  }
}