import 'dart:ffi';

class Ride {
  final String user;
  final String driver;
  final String pickup_location;
  final String destination_location;
  final double distance;
  final String type_of_ride;
  final double base_fare;
  final double total_received;
  final bool completed;
  final DateTime date;
  final List<String> shared_with_friends;

  Ride({
    required this.user,
    required this.driver,
    required this.pickup_location,
    required this.destination_location,
    required this.distance,
    required this.type_of_ride,
    required this.base_fare,
    required this.total_received,
    required this.completed,
    required this.date,
    required this.shared_with_friends,
  });

  Ride copyWith({
    String? user,
    String? driver,
    String? pickup_location,
    String? destination_location,
    double? distance,
    String? type_of_ride,
    double? base_fare,
    double? total_received,
    bool? completed,
    DateTime? date,
    List<String>? shared_with_friends,
  }) {
    return Ride(
      user: user ?? this.user,
      driver: driver ?? this.driver,
      pickup_location: pickup_location ?? this.pickup_location,
      destination_location: destination_location ?? this.destination_location,
      distance: distance ?? this.distance,
      type_of_ride: type_of_ride ?? this.type_of_ride,
      base_fare: base_fare ?? this.base_fare,
      total_received: total_received ?? this.total_received,
      completed: completed ?? this.completed,
      date: date ?? this.date,
      shared_with_friends: shared_with_friends ?? this.shared_with_friends,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'driver': driver,
      'pickup_location': pickup_location,
      'destination_location': destination_location,
      'distance': distance,
      'type_of_ride': type_of_ride,
      'base_fare': base_fare,
      'total_received': total_received,
      'completed': completed,
      'date': date.toIso8601String(),
      'shared_with_friends': shared_with_friends,
    };
  }

  factory Ride.fromMap(Map<String, dynamic> map) {
    return Ride(
      user: map['user'].toString(),
      driver: map['driver'].toString(),
      pickup_location: map['pickup_location'].toString(),
      destination_location: map['destination_location'].toString(),
      distance: map['distance'] is double
          ? map['distance']
          : double.parse(map['distance'].toString()),
      type_of_ride: map['type_of_ride'].toString(),
      base_fare: map['base_fare'] is double
          ? map['base_fare']
          : double.parse(map['base_fare'].toString()),
      total_received: map['total_received'] is double
          ? map['total_received']
          : double.parse(map['total_received'].toString()),
      completed: map['completed'] is bool
          ? map['completed']
          : map['completed'].toString() == 'true',
      date: DateTime.parse(map['date']),
      shared_with_friends: List<String>.from(map['shared_with_friends'] ?? []),
    );
  }
}
