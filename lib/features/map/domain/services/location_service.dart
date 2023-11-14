import 'package:bars/features/map/data/models/app_lat_long.dart';

abstract class LocationService {
  Future<AppLatLong> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}