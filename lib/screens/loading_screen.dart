import 'package:flutter/material.dart';
import '../services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var lon, lat;

  @override
  void initState() {
    super.initState();
    getWeatherFromLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void getWeatherFromLocation() async {
    Weather weather = await WeatherModel().getWeatherByLocation();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weather: weather);
    }));
  }
}
