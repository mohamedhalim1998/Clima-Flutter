import 'package:geolocator/geolocator.dart';

class Location {
  var lat, lon;

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      lat = position.latitude.toInt();
      lon = position.longitude.toInt();
    } catch (e) {
      print("can't get the location");
    }
  }
}
