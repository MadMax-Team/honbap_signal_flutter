import 'package:geolocator/geolocator.dart';

class LocationRepository {
  Future<bool> checkAndRequestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return true;
  }

  Future<Position> fetchLocation() async {
    bool hasPermission = await checkAndRequestPermission();
    if (!hasPermission) {
      return Future.error('Location permission not granted.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
