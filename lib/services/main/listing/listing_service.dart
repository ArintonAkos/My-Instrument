import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/services/models/requests/main/listing/listing_request.dart';
import 'package:my_instrument/services/models/responses/base_response.dart' as my_base_response;
import 'package:my_instrument/services/models/responses/main/listing/listing_constants.dart';
import 'package:my_instrument/services/models/responses/main/listing/listing_response.dart';

import '../../http_service.dart';

class ListingService extends HttpService {
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

        ListingResponse response = ListingResponse(body);
        return response;
      }
    }
    return my_base_response.BaseResponse.error();
  }
}