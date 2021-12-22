
enum ResponseStatus {
  success,
  fail
}

class FutureResponse {
  Object? exception;
  List<dynamic>? data;
  late bool success;
  final int? statusCode;

  FutureResponse({
    this.exception,
    this.data,
    this.statusCode
  }) {
    success = (exception == null);
  }

}