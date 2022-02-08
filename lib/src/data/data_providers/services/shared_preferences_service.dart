import 'dart:convert';
import 'package:my_instrument/src/data/models/view_models/shared_preferences_data.dart';

import 'shared_prefs.dart';

class SharedPreferencesService {

  Type getData<Type>(String key, Type Function(Map<String, dynamic>) buildData, Type Function() defaultBuilder) {
    String? storedData = SharedPrefs.instance.getString(key);

    if (storedData != null) {
      Map<String, dynamic> decodedData = jsonDecode(storedData);
      return buildData(decodedData);
    }

    return defaultBuilder();
  }

  deleteData(String key) async {
    await SharedPrefs.instance.remove(key);
  }

  saveData(String key, SharedPreferencesData model) async {
    String encodedData = jsonEncode(model.toJson());

    await SharedPrefs.instance.setString(key, encodedData);
  }
}