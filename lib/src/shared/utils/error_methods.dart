

String getErrorMessage(Exception e) {
  return e.toString().replaceFirst(RegExp('^.*Exception: '), '');
}