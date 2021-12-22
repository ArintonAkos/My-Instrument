class Settings {
  Settings({
    required this.languageId,
    required this.themeId,
    required this.notificationEnabled
  });

  final int languageId;
  final int themeId;
  final bool notificationEnabled;

  factory Settings.fromJson(Map<String, dynamic>? json) {
    return Settings(
      languageId: json?['languageId'] ?? 0,
      themeId: json?['theme'] ?? 0,
      notificationEnabled: json?['notificationEnabled'] ?? true
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'languageId': languageId,
      'themeId': themeId,
      'notificationEnabled': notificationEnabled
    };
  }
}