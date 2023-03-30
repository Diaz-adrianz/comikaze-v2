import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/local.dart';

class LocalSave {
  String? key;
  List<LocalSaveModel>? data;

  LocalSave(String _key, List<LocalSaveModel> _data) {
    key = _key;
    data = _data;
  }

  void set() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonData = [];

    if (data != null) {
      for (var element in data!) {
        jsonData.add(element.toJson());
      }
    }

    String dataStr = json.encode(jsonData);
    prefs.setString(key!, dataStr);
  }

  Future<List<LocalSaveModel>> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<LocalSaveModel> modeledData = [];

    var dataa = prefs.getString(key!);

    if (dataa != null) {
      var jsonData = json.decode(dataa);

      if (jsonData != null) {
        jsonData.forEach((element) {
          modeledData.add(LocalSaveModel.fromJson(element));
        });
      }
    }

    return modeledData;
  }

  // }
  // GET FAVORIT & SAVED
}
