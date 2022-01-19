import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/src/data/data_providers/services/http_service.dart';
import 'package:my_instrument/src/data/data_providers/constants/favorite_constants.dart';
import 'package:my_instrument/src/data/models/requests/main/favorite/favorite_request.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/src/data/models/responses/main/favorite/get_favorites_response.dart';

class FavoriteService extends HttpService {
  Future<my_base_response.BaseResponse> getFavorites() async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(FavoriteConstants.getFavoritesURL);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        GetFavoritesResponse response = GetFavoritesResponse(body);
        return response;
      }
    }

    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> addFavorite(FavoriteRequest request) async {
    if (await model.ensureAuthorized()) {
      Response res = await putData(FavoriteConstants.putFavoriteURL + request.toString());

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        my_base_response.BaseResponse response = my_base_response.BaseResponse(body);
        return response;
      }
    }

    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> removeFavorite(FavoriteRequest request) async {
    if (await model.ensureAuthorized()) {
      Response res = await deleteData(FavoriteConstants.deleteFavoriteURL + request.toString());

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        my_base_response.BaseResponse response = my_base_response.BaseResponse(body);
        return response;
      }
    }

    return my_base_response.BaseResponse.error();
  }
}