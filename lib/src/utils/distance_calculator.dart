import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

double getDistance(List<LatLng> coordinates) {
  double totalDistance = 0;
  for (int i = 0; i < coordinates.length - 1; i++) {
    totalDistance += calculateDistance(
        coordinates[i].latitude,
        coordinates[i].longitude,
        coordinates[i + 1].latitude,
        coordinates[i + 1].longitude);
  }
  return totalDistance;
}