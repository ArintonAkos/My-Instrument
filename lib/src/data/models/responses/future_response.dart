
enum ResponseStatus {
  success,
  fail
}

class FutureResponse {
  Object? exception;
  dynamic data;
  final int? statusCode;

  FutureResponse({
    this.exception,
    this.data,
    this.statusCode
  });

  get success => (exception == null);
}