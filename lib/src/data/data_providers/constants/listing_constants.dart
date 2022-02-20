import 'package:my_instrument/src/data/data_providers/services/http_service.dart';

class ListingConstants {
  static const _listingURL = 'Listing/';

  static const getListingsURL = _listingURL + 'GetListings';

  static const getListingURL = _listingURL;

  static const deleteListingURL = _listingURL;

  static const createListingURL = _listingURL + 'Create';

  static const editListingURL = _listingURL + 'Edit';

  static String fullListingPathURL = HttpService.basicUrl + 'listing/';
}