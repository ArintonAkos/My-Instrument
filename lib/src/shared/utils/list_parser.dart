class ListParser {
  static List<Type> parse<Type>(dynamic childrenRaw, Type? Function(Map<String, dynamic> value) parseType) {
    if (childrenRaw != null) {
      List<Map<String, dynamic>>? children = List<Map<String, dynamic>>.from(childrenRaw);
      List<Type> list = [];

      for (var value in children) {
        var actualValue = parseType(value);
        if (actualValue != null) {
          list.add(actualValue);
        }
      }

      return list;
    }

    return List.empty();
  }
}