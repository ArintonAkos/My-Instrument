import 'package:my_instrument/bloc/main/shopping_cart/cart_item_data.dart';
import 'package:my_instrument/services/models/responses/base_response.dart';
import 'package:my_instrument/shared/utils/list_parser.dart';

class GetCartItemsResponse extends BaseResponse {
  late final List<CartItemData> cartItems;

  GetCartItemsResponse(Map<String, dynamic> json) : super(json) {
    cartItems = ListParser.parse(json['items'], CartItemData.fromJson);
  }
}