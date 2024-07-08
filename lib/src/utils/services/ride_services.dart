import 'package:everide_frontend/src/constants/api_path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/my_user_model.dart';
import '../../models/ride.dart';

class RideService {
  //assuming only user ride 1
  Future<List<Ride>> getAll() async {
    const url = '${api}ride/1';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        try {
          final List<dynamic> json = jsonDecode(response.body);
          final rides = json.map((e) {
            return Ride(
              user: e['user']?.toString() ?? '',
              driver: e['driver']?.toString() ?? '',
              pickupLocation: e['pickup_location']?.toString() ?? '',
              destinationLocation: e['destination_location']?.toString() ?? '',
              distance: e['distance'] is double
                  ? e['distance']
                  : double.parse(e['distance'].toString()),
              typeOfRide: e['type_of_ride']?.toString() ?? '',
              baseFare: e['base_fare'] is double
                  ? e['base_fare']
                  : double.parse(e['base_fare'].toString()),
              totalReceived: e['total_received'] is double
                  ? e['total_received']
                  : double.parse(e['total_received'].toString()),
              completed: e['completed'] is bool
                  ? e['completed']
                  : e['completed'].toString() == 'true',
              date: DateTime.parse(e['date']),
              sharedWithFriends:[] //assuming shared with friends is empty as currently the data fetched from django is int instead of user,
            );
          }).toList();
          return rides;
        } catch (e) {
          throw Exception('Failed to parse rides: $e');
        }
      } else {
        print('Response status: ${response.statusCode}');
        print('Response headers: ${response.headers}');
        print('Response body: ${response.body}');
        throw Exception(
            'Failed to load rides, status code: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load rides: $e');
    }
  }

  //TODO shared_w_friends should return MyUser
  Future<Ride> createRide(Map<String, dynamic> rideData) async {
    final url = Uri.parse('$api/create/');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(rideData),
      );
      if (response.statusCode == 200) {
        final Map<dynamic, dynamic> res = jsonDecode(response.body);
        return Ride(
          user: res['user']?.toString() ?? '',
          driver: res['driver']?.toString() ?? '',
          pickupLocation: res['pickup_location']?.toString() ?? '',
          destinationLocation: res['destination_location']?.toString() ?? '',
          distance: res['distance'] is double
              ? res['distance']
              : double.parse(res['distance'].toString()),
          typeOfRide: res['type_of_ride']?.toString() ?? '',
          baseFare: res['base_fare'] is double
              ? res['base_fare']
              : double.parse(res['base_fare'].toString()),
          totalReceived: res['total_received'] is double
              ? res['total_received']
              : double.parse(res['total_received'].toString()),
          completed: res['completed'] is bool
              ? res['completed']
              : res['completed'].toString() == 'true',
          date: DateTime.parse(res['date']),
          sharedWithFriends: (res['shared_with_friends'] as List<dynamic>?)
                  ?.map((item) => MyUser.fromMap(item))
                  .toList() ??
              [],
        );
      } else {
        throw Exception(
            'Failed to create ride: ${response.body}${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create ride: $e');
    }
  }

  Future<bool> completeRide(int rideId) async {
    //now the static id is currently 14
    const rideId = 14;
    final url = Uri.parse('$api/complete/$rideId/');

    final response = await http.put(
      url,
      // headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      // },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to complete the ride. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    return false;
  }
}
