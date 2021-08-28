enum CallerClass {
  SharedPreferences
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
    return '${this.callerClass.name} was not initialized!';
  }
}