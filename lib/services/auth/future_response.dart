
enum ResponseStatus {
  success,
  fail
}

extension on ResponseStatus {
  bool get status {
    return [true, false][this.index];
  }
}

class FutureResponse {
  Object? exception;
  List<dynamic>? data;
  late bool success;

  FutureResponse({
    this.exception,
    this.data
  }) {
    this.success = (this.exception == null);
  }

}