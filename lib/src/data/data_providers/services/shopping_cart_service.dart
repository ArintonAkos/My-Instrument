import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/data/data_providers/services/http_service.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/src/data/models/responses/main/shopping_cart/get_cart_items_response.dart';
import 'package:my_instrument/src/data/data_providers/constants/shopping_cart_constants.dart';


class ShoppingCartService extends HttpService {
  ShoppingCartService({ required AppLanguage appLanguage}) : super(appLanguage: appLanguage);

  Future<my_base_response.BaseResponse> getCartItems() async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(ShoppingCartConstants.allItems);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        GetCartItemsResponse getCartItemsResponse = GetCartItemsResponse(body, appLanguage);
        return getCartItemsResponse;
      }
    }

    return my_base_response.BaseResponse.error(appLanguage);
  }
}