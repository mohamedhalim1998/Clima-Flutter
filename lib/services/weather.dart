import 'location.dart';
import 'networking.dart';

class WeatherModel {
  Future<Weather> getWeatherByLocation() async {
    Location location = Location();
    await location.getLocation();
    var lat = location.lat;
    var lon = location.lon;
    NetworkHelper networkHelper = NetworkHelper(lat: lat, lon: lon);
    var weatherData = await networkHelper.getData();
    return Weather(weatherData);
  }

  Future<Weather> getWeatherByCity(String city) async {
    NetworkHelper networkHelper = NetworkHelper.fromCity(city: city.toLowerCase());
    var weatherData = await networkHelper.getData();
    return Weather(weatherData);
  }
}

class Weather {
  var _weatherData;
  int _temperature;
  String _weatherIcon;
  String _weatherMessage;
  String _cityName;

  Weather(this._weatherData) {
    _temperature = _weatherData['main']['temp'].toInt();
    var condition = _weatherData['weather'][0]['id'];
    _weatherIcon = getWeatherIcon(condition);
    _weatherMessage = getMessage(_temperature);
    _cityName = _weatherData['name'];
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  String get cityName => _cityName;

  String get weatherMessage => _weatherMessage;

  String get weatherIcon => _weatherIcon;

  int get temperature => _temperature;
}
