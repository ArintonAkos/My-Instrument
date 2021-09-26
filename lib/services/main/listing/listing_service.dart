import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_instrument/services/models/requests/main/listing/listing_request.dart';
import 'package:my_instrument/services/models/responses/base_response.dart' as MyBaseResponse;
import 'package:my_instrument/services/models/responses/main/category/category_constants.dart';
import 'package:my_instrument/services/models/responses/main/category/category_response.dart';
import 'package:my_instrument/services/models/responses/main/listing/listing_constants.dart';
import 'package:my_instrument/services/models/responses/main/listing/listing_response.dart';

import '../../http_service.dart';

class ListingService extends HttpService {
  Future<MyBaseResponse.BaseResponse> getListing(String listingId, { int language = 0 }) async {
    if (await this.model.ensureAuthorized()) {
      Response res = await getData(ListingConstants.GetListingURL + '${listingId}?language=${language}');

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        ListingResponse response = ListingResponse(body);
        return response;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }

  Future<MyBaseResponse.BaseResponse> createListing(ListingRequest listingRequest) async {
    if (await this.model.ensureAuthorized()) {
      StreamedResponse res = await postMultipart(
        listingRequest,
        ListingConstants.CreateListingURL
      );

      final respStr = await res.stream.bytesToString();
      if (res.statusCode == 200) {
        dynamic body = jsonDecode(respStr);

        ListingResponse response = ListingResponse(body);
        return response;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }

  Future<MyBaseResponse.BaseResponse> editListing(ListingRequest listingRequest) async {
    if (await this.model.ensureAuthorized()) {
      StreamedResponse res = await postMultipart(
          listingRequest,
          ListingConstants.GetListingURL
      );

      final respStr = await res.stream.bytesToString();
      if (res.statusCode == 200) {
        dynamic body = jsonDecode(respStr);

        ListingResponse response = ListingResponse(body);
        return response;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }

  Future<MyBaseResponse.BaseResponse> deleteListing(String listingId, { int? languageId = 0 }) async {
    if (await this.model.ensureAuthorized()) {
      Response res = await deleteData(ListingConstants.DeleteListingURL + '${listingId}?language=${languageId}');

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);

        ListingResponse response = ListingResponse(body);
        return response;
      }
    }
    return MyBaseResponse.BaseResponse.error();
  }
}