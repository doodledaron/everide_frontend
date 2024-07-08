import 'package:everide_frontend/database/driver_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/driver_model.dart';

class DriverProvider with ChangeNotifier {
  List<Driver> _drivers = [];
  List<LatLng> _driverLatLng = [];

  List<Driver> get drivers => _drivers;
  List<LatLng> get driverLatLng => _driverLatLng;

  void loadDrivers() {
    _drivers = DriverDatabase().drivers;
    _driverLatLng = _drivers.map((e) => e.currentLocation).toList();
    notifyListeners();
  }

  // LatLng convertToLatLng(String latitude, String longitude) {
  //   return LatLng(
  //     double.parse(latitude),
  //     double.parse(longitude),
  //   );
  // }
}
