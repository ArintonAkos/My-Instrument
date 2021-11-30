class ProfileModel {
  Map<String, dynamic>? json;

  ProfileModel({required this.json}) {
    id = json?['id'];
    firstName = json?['firstName'];
    lastName = json?['lastName'];
  }

  late final String id;
  late final String firstName;
  late final String lastName;
  late final List<String> listings;

  String get fullName {
    return firstName + " " + lastName;
  }
}
