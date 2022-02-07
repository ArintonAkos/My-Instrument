import 'dart:convert';
import 'package:my_instrument/src/data/models/view_models/shared_preferences_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  Future<Type> getData<Type>(String key, Type Function(Map<String, dynamic>) buildData, Type Function() defaultBuilder) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? storedData = sharedPreferences.getString(key);

    if (storedData != null) {
      Map<String, dynamic> decodedData = jsonDecode(storedData);
      return buildData(decodedData);
    }

    return defaultBuilder();
  }

  deleteData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  saveData(String key, SharedPreferencesData model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String encodedData = jsonEncode(model.toJson());

    await sharedPreferences.setString(key, encodedData);
  }
}