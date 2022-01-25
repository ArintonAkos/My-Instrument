import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/src/data/data_providers/services/http_service.dart';
import 'package:my_instrument/src/data/data_providers/constants/listing_constants.dart';
import 'package:my_instrument/src/data/models/requests/main/listing/get_listings_request.dart';
import 'package:my_instrument/src/data/models/requests/main/listing/listing_request.dart';
import 'package:my_instrument/src/data/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/src/data/models/responses/main/listing/get_listings_response.dart';
import 'package:my_instrument/src/data/models/responses/main/listing/listing_response.dart';

class ListingService extends HttpService {

  Future<my_base_response.BaseResponse> getListings(GetListingsRequest request, { int language = 0 }) async {
    if (await model.ensureAuthorized()) {
      Response res = await postJson(request, ListingConstants.getListingsURL);

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        GetListingsResponse response = GetListingsResponse(body);
        return response;
      }
    }

    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> getListing(String listingId, { int language = 0 }) async {
    if (await model.ensureAuthorized()) {
      Response res = await getData(ListingConstants.getListingURL + '$listingId?language=$language');

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        ListingResponse response = ListingResponse(body);
        return response;
      }
    }
    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> createListing(ListingRequest listingRequest) async {
    if (await model.ensureAuthorized()) {
      StreamedResponse res = await postMultipart(
        listingRequest,
        ListingConstants.createListingURL
      );

      final respStr = await res.stream.bytesToString();
      if (res.statusCode == 200) {
        dynamic body = jsonDecode(respStr);

        ListingResponse response = ListingResponse(body);
        return response;
      }
    }
    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> editListing(ListingRequest listingRequest) async {
    if (await model.ensureAuthorized()) {
      StreamedResponse res = await postMultipart(
          listingRequest,
          ListingConstants.getListingURL
      );

      final respStr = await res.stream.bytesToString();
      if (res.statusCode == 200) {
        dynamic body = jsonDecode(respStr);

        ListingResponse response = ListingResponse(body);
        return response;
      }
    }
    return my_base_response.BaseResponse.error();
  }

  Future<my_base_response.BaseResponse> deleteListing(String listingId, { int? languageId = 0 }) async {
    if (await model.ensureAuthorized()) {
      Response res = await deleteData(ListingConstants.deleteListingURL + '$listingId?language=$languageId');

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        my_base_response.BaseResponse response = ListingResponse(body);
        return response;
      }
    }
    return my_base_response.BaseResponse.error();
  }
}