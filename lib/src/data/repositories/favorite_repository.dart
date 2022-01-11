import 'package:my_instrument/src/data/data_providers/services/favorite_service.dart';
import 'package:my_instrument/src/data/models/requests/main/favorite/favorite_request.dart';
import 'package:my_instrument/src/data/models/responses/main/favorite/get_favorites_response.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';

class FavoriteRepository {
  final FavoriteService _favoriteService = appInjector.get<FavoriteService>();

  Future<List<String>> getFavorites() async {
    var res = await _favoriteService.getFavorites();

    if (res.ok) {
      return (res as GetFavoritesResponse).favorites;
    }

    throw Exception(res.message);
  }

  Future<bool> addFavorite(String listingId) async {
    var res = await _favoriteService.addFavorite(FavoriteRequest(listingId: listingId));

    if (res.ok) {
      return true;
    }

    throw Exception(res.message);
  }

  Future<bool> removeFavorite(String listingId) async {
    var res = await _favoriteService.removeFavorite(FavoriteRequest(listingId: listingId));

    if (res.ok) {
      return true;
    }

    throw Exception(res.message);
  }
}