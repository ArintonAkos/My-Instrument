class ParsableDateTime {
  final DateTime? dateTime;

  ParsableDateTime({
    required this.dateTime
  });

  String toJson() {
    return this.dateTime?.toIso8601String() ?? '';
  }

  factory ParsableDateTime.fromJson(String? IsoString) {
    var dateTime = null;
    if (IsoString != null) {
      try {
        dateTime = DateTime.parse(IsoString);
      } catch (exception) {}
    }
    return ParsableDateTime(dateTime: dateTime);
  }
}