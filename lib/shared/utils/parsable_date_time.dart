class ParsableDateTime {
  final DateTime? dateTime;

  ParsableDateTime({
    required this.dateTime
  });

  String toJson() {
    return dateTime?.toIso8601String() ?? '';
  }

  factory ParsableDateTime.fromJson(String? IsoString) {
    DateTime? dateTime;

    if (IsoString != null) {
      try {
        dateTime = DateTime.parse(IsoString);
      } catch (exception) {}
    }

    return ParsableDateTime(dateTime: dateTime);
  }
}