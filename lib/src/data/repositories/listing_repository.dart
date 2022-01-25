import 'package:my_instrument/src/data/data_providers/services/listing_service.dart';
import 'package:my_instrument/src/data/models/requests/main/listing/get_listings_request.dart';
import 'package:my_instrument/src/data/models/requests/main/listing/listing_request.dart';
import 'package:my_instrument/src/data/models/responses/main/listing/get_listings_response.dart';
import 'package:my_instrument/src/data/models/responses/main/listing/listing_model.dart';
import 'package:my_instrument/src/data/models/responses/main/listing/listing_response.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';

class ListingRepository {
  final ListingService _listingService = appInjector.get<ListingService>();

  Future<List<ListingModel>> getListings(GetListingsRequest request) async {
    var res = await _listingService.getListings(request);

    if (res.ok) {
      return (res as GetListingsResponse).listings;
    }

    throw Exception(res.message);
  }

  Future<ListingModel> getListing(String listingId, { int language = 0}) async {
    var res = await _listingService.getListing(listingId, language: language);

    if (res.ok) {
      return (res as ListingResponse).listing;
    }

    throw Exception(res.message);
  }

  Future<ListingModel> createListing(ListingRequest listingRequest) async {
    var res = await _listingService.createListing(listingRequest);

    if (res.ok) {
      return (res as ListingResponse).listing;
    }

    throw Exception(res.message);
  }

  Future<ListingModel> editListing(ListingRequest listingRequest) async {
    var res = await _listingService.editListing(listingRequest);

    if (res.ok) {
      return (res as ListingResponse).listing;
    }

    throw Exception(res.message);
  }

  Future<bool> deleteListing(String listingId, { int language = 0}) async {
    var res = await _listingService.deleteListing(listingId, languageId: language);

    if (res.ok) {
      return true;
    }

    throw Exception(res.message);
  }
}