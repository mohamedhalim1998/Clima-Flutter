import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final Weather weather;

  LocationScreen({this.weather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Weather weather;

  @override
  void initState() {
    super.initState();
    updateUi(widget.weather);
  }

  updateUi(Weather weather) {
    setState(() {
      this.weather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      Weather weather =
                          await WeatherModel().getWeatherByLocation();
                      updateUi(weather);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var city = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      Weather weather = await WeatherModel()
                          .getWeatherByCity(city.toString());
                      updateUi(weather);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${weather.temperature}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weather.weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weather.weatherMessage} in ${weather.cityName}",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
