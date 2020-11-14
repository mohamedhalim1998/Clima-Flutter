import 'dart:convert';

import 'package:clima/utilities/api_key.dart';
import 'package:http/http.dart' as http;

import '../utilities/constants.dart';

class NetworkHelper {
  var lon, lat;
  var city;
  String url;

  NetworkHelper({this.lat, this.lon}) {
    url = kBaseUrl + "lat=$lat&lon=$lon&units=metric&appid=$API_KEY";
    print(url);
  }

  NetworkHelper.fromCity({this.city}) {
    url = kBaseUrl + "q=$city&units=metric&appid=$API_KEY";
    print(url);
  }

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print("can't get data check internet connection");
    }
  }
}
