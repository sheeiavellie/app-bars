import 'package:bars/features/map/domain/app_lat_long.dart';
import 'package:bars/features/map/domain/services/app_location.dart';
import 'package:geolocator/geolocator.dart';

class LocationService implements AppLocation {
  final defLocation = const StPetersburgLocation(); 
  
  @override
  Future<AppLatLong> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLong(lat: value.latitude, long: value.longitude);
    }).catchError(
      (_) => defLocation,
    );
  }
  
  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
      .then((value) =>
          value == LocationPermission.always ||
          value == LocationPermission.whileInUse)
      .catchError((_) => false);
  }

  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
      .then((value) =>
          value == LocationPermission.always ||
          value == LocationPermission.whileInUse)
      .catchError((_) => false);
  }
}