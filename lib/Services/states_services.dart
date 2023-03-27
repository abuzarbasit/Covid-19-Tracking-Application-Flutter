import 'dart:convert';


import 'package:covidapp/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;

import '../Model/WorldStatesModel.dart';

class StateServices {
  Future<WorldStatesModel> fetchWorldStates() async {
    final response = await http.get(Uri.parse(AppURL.worldStatesAPI));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> fetchCountriesList() async {
    var data;
    final response = await http.get(Uri.parse(AppURL.countriesList));
    if (response.statusCode == 200) {
       data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
