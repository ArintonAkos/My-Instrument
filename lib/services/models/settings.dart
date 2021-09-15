class Settings {
  Settings({
    required this.LanguageId,
    required this.ThemeId,
    required this.NotificationEnabled
  });

  final int LanguageId;
  final int ThemeId;
  final bool NotificationEnabled;

  factory Settings.fromJson(Map<String, dynamic>? json) {
    return Settings(
      LanguageId: json?['languageId'] ?? 0,
      ThemeId: json?['theme'] ?? 0,
      NotificationEnabled: json?['notificationEnabled'] ?? true
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'languageId': this.LanguageId,
      'themeId': this.ThemeId,
      'notificationEnabled': this.NotificationEnabled
    };
  }
}