class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

class StPetersburgLocation extends AppLatLong {
  const StPetersburgLocation({
    super.lat = 59.937500,
    super.long = 30.308611,
  });
}
