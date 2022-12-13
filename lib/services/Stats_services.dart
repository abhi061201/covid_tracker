import 'dart:convert';

import 'package:covid_tracker/Models/WorldStatsModel.dart';
import 'package:covid_tracker/services/Utilities/appUrl.dart';
import 'package:http/http.dart' as http;

class StatesServices{

  Future <WorldStatsModel> fetchWorldStatesRecord ()async{
    var response = await http.get(Uri.parse(appurl.worldStatsApi));
    if(response.statusCode==200)
    {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    }
    else {

      throw Exception('Error');
    }
  }
   Future <List<dynamic>> fetchCountrienRecord ()async{
    var data;
    var response = await http.get(Uri.parse(appurl.countriesList));
    if(response.statusCode==200)
    {
       data = jsonDecode(response.body);
      return data;
    }
    else {

      throw Exception('Error');
    }
  }
}