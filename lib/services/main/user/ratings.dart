import 'package:parse_server_sdk/parse_server_sdk.dart';

class RatingsService {
  getUserRatings() async {
    ParseCloudFunction function = ParseCloudFunction('getRatings');
    final ParseResponse parseResponse = await function.execute();
    if (parseResponse.success && parseResponse.result != null) {
      print(parseResponse.result);
    }
    var a = parseResponse.result;
  }
}