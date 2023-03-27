import 'package:flutter/material.dart';

class AppURL {
  // This is our base URL
  static const String baseURL = "https://disease.sh/v3/covid-19/";

  // Fetch world covid states
  static const String worldStatesAPI = "${baseURL}all";
  static const String countriesList = "${baseURL}countries";
}
