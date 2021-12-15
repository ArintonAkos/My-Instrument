class ParsableDateTime {
  final DateTime? dateTime;

  ParsableDateTime({
    required this.dateTime
  });

  String toJson() {
    return dateTime?.toIso8601String() ?? '';
  }

  factory ParsableDateTime.fromString(String? isoString) {
    DateTime? dateTime;

    if (isoString != null) {
      try {
        dateTime = DateTime.parse(isoString);
      } catch (exception) {}
    }

    return ParsableDateTime(dateTime: dateTime);
  }
}