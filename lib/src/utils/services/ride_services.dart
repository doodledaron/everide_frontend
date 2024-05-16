import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constants/api_path.dart';
import '../../models/ride.dart';

class RideService {
  Future<List<Ride>> getAll() async {
    const url = '${api}ride/';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final ride = json.map((e) {
        return Ride(
          user: e['user'],
          driver: e['driver'],
          pickup_location: e['pickup_location'],
          destination: e['destination'],
          base_fare: e['base_fare'],
          extra_tips: e['extra_tips'],
          total_received: e['total_received'],
          completed: e['completed'],
          date: e['date'],
          shared_with_friends: e['shared_with_friends'],
        );
      }).toList();
      return ride;
    } else {
      throw Exception('Failed to load rides');
    }
  }
}
