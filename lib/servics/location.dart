// ignore_for_file: empty_catches, unused_local_variable
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
class Location {
  double? latitude;
  double? longitude;
  Future getCurrentLocation() async {
    Position? position;

    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {}
    return position;
  }

  Future<void> requestPermission() async {
    await Permission.location.request();
  }
}
