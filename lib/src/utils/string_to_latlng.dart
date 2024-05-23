import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng stringToLatLng(String latStr, String lngStr) {
  double latitude = double.parse(latStr);
  double longitude = double.parse(latStr);
  return LatLng(latitude, longitude);
}

