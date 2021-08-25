
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
  late bool success;

  FutureResponse({
    this.exception
  }) {
    this.success = (this.exception == null);
  }

}