import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants/api_path.dart';
import '../../models/booking_history.dart';

class BookingHistoryService {
  Future<List<BookingHistory>> getBookingHistory() async {
    const url = '${api}booking_history/14/';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        try {
          final List<dynamic> json = jsonDecode(response.body);
          final rides = json.map((e) {
            return BookingHistory(
              user: e['user']?.toString() ?? '',
              driver: e['driver']?.toString() ?? '',
              pickup_location: e['pickup_location']?.toString() ?? '',
              destination_location: e['destination_location']?.toString() ?? '',
              distance: e['distance'] is double
                  ? e['distance']
                  : double.parse(e['distance'].toString()),
              type_of_ride: e['type_of_ride']?.toString() ?? '',
              base_fare: e['base_fare'] is double
                  ? e['base_fare']
                  : double.parse(e['base_fare'].toString()),
              total_received: e['total_received'] is double
                  ? e['total_received']
                  : double.parse(e['total_received'].toString()),
              completed: e['completed'] is bool
                  ? e['completed']
                  : e['completed'].toString() == 'true',
              date: DateTime.parse(e['date']),
              shared_with_friends: (e['shared_with_friends'] as List<dynamic>?)
                      ?.map((item) => item.toString())
                      .toList() ??
                  [],
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
}
