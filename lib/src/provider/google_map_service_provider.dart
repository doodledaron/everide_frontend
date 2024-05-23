// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/api_path.dart';
import '../utils/services/google_map_services.dart';

class GoogleMapServiceProvider with ChangeNotifier {
  final GoogleMapServices _googleMapServices = GoogleMapServices();
  LatLng? currentPosition;
  List<Map<String, dynamic>> placesForAutocomplete = [];
  String pickUpLocation = '';
  List<Map<String, dynamic>> nearbyPlacesFromCurrentLocation = [];
  Map<String, dynamic> selectedPickUpLocation = {}; //selected pickup
  Map<String, dynamic> selectedDestinationLocation = {}; //selected pickup

  List<LatLng>? coordinatesFromUserToDestination; //to calculate the distance
  List<LatLng>? coordinatesFromDriverToUser;

  double? _totalDistance;

  //will be initialized in primary map screen
  Future<void> initializeCurrentLocationUpdates() async {
    await _googleMapServices.fetchCurrentLocationUpdates((position) {
      currentPosition = position;
      notifyListeners();
    });
  }

//fetch data

  //fetch place name autocomplete suggestions
  Future<void> fetchPlaceNameAutocomplete(
      String input, String sessionToken) async {
    try {
      placesForAutocomplete = await _googleMapServices.getPlaceNameAutocomplete(
          input, sessionToken);
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow; //rethrow exception
    }
  }

  //used in select destination to get the default pickup location first
  // Fetch pick-up location from LatLng
  Future<void> fetchPickUpLocation(LatLng currentLocation) async {
    try {
      pickUpLocation =
          await _googleMapServices.getPickUpLocationFromLatLng(currentLocation);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> fetchNearbyPlacesFromCurrentLocation(
      LatLng currentLocation) async {
    try {
      nearbyPlacesFromCurrentLocation = await _googleMapServices
          .getNearbyPlaceFromCurrentLocation(currentLocation);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

//set the data
  void saveSelectedPickUpLocation(Map<String, dynamic> location) {
    selectedPickUpLocation = location;
  }

  //set the data
  Future<void> saveSelectedDestinationLocation(
      Map<String, dynamic> location) async {
    try {
      final placeId = location['place_id'];
      selectedDestinationLocation =
          await _googleMapServices.getPlaceDetailsFromPlaceId(placeId);

      Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchPolylinePoints(LatLng pickUpLocation,
      LatLng destinationLocation, bool isUserToDriver) async {
    final polylinePoints = PolylinePoints();

    // This will get routes between the pickup and destination locations
    final result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapApi,
        PointLatLng(pickUpLocation.latitude, pickUpLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude),
        travelMode: TravelMode.driving);

    if (result.points.isNotEmpty) {
      // Map the PolylinePoints into LatLng
      if (isUserToDriver) {
        coordinatesFromUserToDestination = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      } else {
        coordinatesFromDriverToUser = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      }
    } else {
      debugPrint(result.errorMessage);
    }
  }

//others
  void cancelCurrentLocationUpdates() {
    _googleMapServices.cancelCurrentLocationUpdates();
  }
}
