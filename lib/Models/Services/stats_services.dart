import 'dart:convert';

import 'package:covid_tracker/Models/Services/Utilities/api_utils.dart';
import 'package:covid_tracker/Models/all_stats.dart';
import 'package:covid_tracker/Models/world_stats_model.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  Future<WorldStatesModel> statsServices() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('failed');
    }
  }

  Future<AllStats> allStats() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return AllStats.fromJson(data);
    } else {
      throw Exception('Failed');
    }
  }

  Future<List<dynamic>> getCountriesList() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed');
    }
  }
}
