import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/services/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/services/models/responses/main/shopping_cart/get_cart_items_response.dart';
import 'package:my_instrument/services/models/responses/main/shopping_cart/shopping_cart_constants.dart';

import '../../http_service.dart';

class ShoppingCartService extends HttpService {
  Future<my_base_response.BaseResponse> getCartItems() async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(ShoppingCartConstants.allItems);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        GetCartItemsResponse getCartItemsResponse = GetCartItemsResponse(body);
        return getCartItemsResponse;
      }
    }

    return my_base_response.BaseResponse.error();
  }
}