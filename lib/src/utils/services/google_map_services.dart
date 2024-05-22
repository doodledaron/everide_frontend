import 'dart:async';
import 'dart:convert';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../constants/api_path.dart';

class GoogleMapServices {
//to get the current location stream
  final Location _locationController = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  final String apiKey = googleMapApi;
  String latLngToString(LatLng latLng) {
    return "${latLng.latitude},${latLng.longitude}";
  }

  Future<LatLng?> fetchCurrentLocationUpdates(
      void Function(LatLng) onLocationUpdateCallback) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    //check if service is enabled
    serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      //request for the service
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    //check if permission is granted
    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      //prompt the user to allow the app access to the location
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        //if not allow, exit
        return null;
      }
    }

    //listen to location changes
    //assign the location controller to the subscription so that we can dispose it later
    _locationSubscription = _locationController.onLocationChanged.listen(
      (LocationData currentLocation) {
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          final currentPosition =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          //update the current location which can bu used later to display the marker
          onLocationUpdateCallback(currentPosition);
          print(currentLocation);
        }
      },
    );
    return null;
  }

  //to find the destination
//places autocomplete

  Future<List<Map<String, dynamic>>> getPlaceNameAutocomplete(
      String input, String sessionToken) async {
    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$apiKey&sessiontoken=$sessionToken&components=country:MY';

      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        List<dynamic> placeList = data['predictions'];
        List<Map<String, dynamic>> placeNames = placeList.map((e) {
          final String name = e["structured_formatting"]["main_text"] as String;
          final String placeId = e['place_id'];
          return {
            'name': name,
            'place_id': placeId,
          };
        }).toList();

        return placeNames;
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      // Debug: Print the error
      print('Error: $e');
      return [];
    }
  }

//reverse geolocation
  Future<String> getPickUpLocationFromLatLng(LatLng currentLocation) async {
    String pickUpLatLngString = latLngToString(currentLocation);
    try {
      String baseURL = 'https://maps.googleapis.com/maps/api/geocode/json';
      String request = '$baseURL?latlng=$pickUpLatLngString&key=$apiKey';
      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        String pickUpLocation =
            json.decode(response.body)['results'][0]['formatted_address'];
        return pickUpLocation;
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
    return '';
  }

  void cancelCurrentLocationUpdates() {
    _locationSubscription?.cancel();
  }

  Future<List<Map<String, dynamic>>> getNearbyPlaceFromCurrentLocation(
      LatLng currentLocation) async {
    String pickUpLatLngString = latLngToString(currentLocation);
    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
      String request =
          '$baseURL?location=$pickUpLatLngString&rankby=distance&key=$apiKey';
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Extract the list of results
        final List<dynamic> results = data['results'];

        // Create a list of maps with name, latitude, and longitude
        final List<Map<String, dynamic>> locations = results.map((result) {
          final name = result['name'];
          final placeId = result['place_id'];
          final lat = result['geometry']['location']['lat'];
          final lng = result['geometry']['location']['lng'];
          final des = result["vicinity"];
          return {
            'name': name,
            'latitude': lat,
            'place_id': placeId,
            'longitude': lng,
            'des': des
          };
        }).toList();

        return locations;

        // print('kena liao: $_placeList');
        // print('THE PLACE LEEEEE${_placeList.length}');
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<Map<String, dynamic>> getPlaceDetailsFromPlaceId(
      String placeId) async {
    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/details/json';
      String request = '$baseURL?place_id=$placeId&key=$apiKey';
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        // Parse the JSON data
        Map<String, dynamic> data = jsonDecode(response.body)['result'];

        // Extract the desired information
        String name = data['name'];
        String vicinity = data['vicinity'];
        double latitude = data['geometry']['location']['lat'];
        double longitude = data['geometry']['location']['lng'];

        return {
          'name': name,
          'vicinity': vicinity,
          'latitude': latitude,
          'longitude': longitude,
        };
      }
    } catch (e) {
      print(e);
    }
    return {};
  }
}
