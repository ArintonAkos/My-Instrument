enum CallerClass {
  sharedPreferences
}

extension on CallerClass {
  get name {
    return ["Shared preferences"][index];
  }
}

class UninitializedException implements Exception {
  final CallerClass callerClass;
  UninitializedException(this.callerClass);

  @override
  String toString() {
    return '${callerClass.name} was not initialized!';
  }
}