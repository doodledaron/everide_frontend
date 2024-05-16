import 'package:flutter/material.dart';

import '../models/ride.dart';
import '../utils/services/ride_services.dart';

class RideProvider extends ChangeNotifier {
  final _service = RideService();
  bool isLoading = false;
  List<Ride> _rides = [];
  List<Ride> get rides => _rides;

  Future<void> getAllRide() async {
    isLoading = true;
    notifyListeners();

    _rides = await _service.getAll();

    isLoading = false;
    notifyListeners();
  }
}
