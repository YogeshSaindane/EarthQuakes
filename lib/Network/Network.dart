import 'dart:convert';

import 'package:google_maps_demo/Model/Quake.dart';
import 'package:http/http.dart';

class Network {
  Future<Quake> getAllQuakes() async {
    var apiURL =
        "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson";

    final response = await get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      print("quake data ${response.body}");
      return Quake.fromJson(json.decode(response.body));
    } else {
      throw Exception("error gettign data");
    }
  }
}
