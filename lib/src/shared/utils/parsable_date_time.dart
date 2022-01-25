class ParsableDateTime {
  final DateTime? dateTime;

  ParsableDateTime({
    required this.dateTime
  });

  String toJson() {
    return dateTime?.toIso8601String() ?? '';
  }

  factory ParsableDateTime.fromString(String? isoString, { bool toLocale = true }) {
    DateTime? dateTime;

    if (isoString != null) {
      try {
        String toLocaleConverter = toLocale ? 'Z' : '';
        dateTime = DateTime.parse(isoString + toLocaleConverter);
      } catch (exception) {}
    }

    return ParsableDateTime(dateTime: dateTime);
  }

  @override
  String toString() {
    return dateTime?.toIso8601String() ?? '';
  }

  toLocaleString() {
    return dateTime?.toString() ?? '';
  }

  get timeStamp {
    return dateTime?.millisecondsSinceEpoch;
  }
}