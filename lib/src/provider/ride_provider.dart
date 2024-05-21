import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    try {
      _rides = await _service.getAll();
    } catch (e) {
      print('Error loading rides: $e');
      _rides = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
