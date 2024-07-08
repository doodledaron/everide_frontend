import 'package:flutter/material.dart';

import '../models/my_user_model.dart';
import '../models/ride.dart';
import '../utils/services/ride_services.dart';

class RideProvider extends ChangeNotifier {
  final _service = RideService();
  bool isLoading = false;
  List<Ride> _rides = [];
  List<Ride> get rides => _rides;

  //to collect data across screens and create a Ride on the last screen
  String user = "1"; // assuming now we only have user 1
  String driver = "2"; //static
  String? pickupLocation;
  String? destinationLocation;
  double? distance;
  String typeOfRide = "Car";
  double baseFare = 1.65;
  double? totalReceived;
  bool? completed = false;
  DateTime? date = DateTime.parse("2024-05-23T16:14:06.040351Z");
  List<MyUser> sharedWithFriends = [];

  void updatePickupLocation(String newPickupLocation) {
    pickupLocation = newPickupLocation;
    notifyListeners();
  }

  void updateDestinationLocation(String newDestinationLocation) {
    destinationLocation = newDestinationLocation;
    notifyListeners();
  }

  void updateDistance(double newDistance) {
    distance = newDistance;
    notifyListeners();
  }

  void updateTotalReceived(double newTotalReceived) {
    totalReceived = newTotalReceived;
    notifyListeners();
  }

  void updateDate(DateTime newDate) {
    date = newDate;
    notifyListeners();
  }

  void addFriend(MyUser friend) {
    sharedWithFriends.add(friend);
    notifyListeners();
  }

  void clearData() {
    pickupLocation = null;
    destinationLocation = null;
    distance = null;
    totalReceived = null;
    completed = false;
    date = null;
    sharedWithFriends = [];
    notifyListeners();
  }

  void createRide() {
    final newRide = Ride(
      user: user,
      driver: driver,
      pickupLocation: pickupLocation!,
      destinationLocation: destinationLocation!,
      distance: distance!,
      typeOfRide: typeOfRide,
      baseFare: baseFare,
      totalReceived: totalReceived!,
      completed: true,
      date: date!,
      sharedWithFriends: sharedWithFriends,
    );

    rides.add(newRide);
  }

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

  // Future<void> getAllRide() async {
  //   isLoading = true;
  //   notifyListeners();

  //   try {
  //     _rides = _rideDatabase.rides;
  //   } catch (e) {
  //     print('Error loading rides: $e');
  //     _rides = [];
  //   }

  //   isLoading = false;
  //   notifyListeners();
  // }

  //TODO create the ride (FOUND DRIVER)

  //TODO Complete ride, once passenger reach
}
