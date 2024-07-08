
import 'package:everide_frontend/src/models/my_user_model.dart';

class Ride {
  final String user;
  final String driver;
  final String pickupLocation;
  final String destinationLocation;
  final double distance;
  final String typeOfRide;
  final double baseFare;
  final double totalReceived;
  final bool completed;
  final DateTime date;
  final List<MyUser> sharedWithFriends;

  Ride({
    required this.user,
    required this.driver,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.distance,
    required this.typeOfRide,
    required this.baseFare,
    required this.totalReceived,
    required this.completed,
    required this.date,
    required this.sharedWithFriends,
  });


  Ride copyWith({
    String? user,
    String? driver,
    String? pickupLocation,
    String? destinationLocation,
    double? distance,
    String? typeOfRide,
    double? baseFare,
    double? totalReceived,
    bool? completed,
    DateTime? date,
    List<MyUser>? sharedWithFriends,
  }) {
    return Ride(
      user: user ?? this.user,
      driver: driver ?? this.driver,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      distance: distance ?? this.distance,
      typeOfRide: typeOfRide ?? this.typeOfRide,
      baseFare: baseFare ?? this.baseFare,
      totalReceived: totalReceived ?? this.totalReceived,
      completed: completed ?? this.completed,
      date: date ?? this.date,
      sharedWithFriends: sharedWithFriends ?? this.sharedWithFriends,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'driver': driver,
      'pickup_location': pickupLocation,
      'destination_location': destinationLocation,
      'distance': distance,
      'type_of_ride': typeOfRide,
      'base_fare': baseFare,
      'total_received': totalReceived,
      'completed': completed,
      'date': date.toIso8601String(),
      'shared_with_friends': sharedWithFriends,
    };
  }

  factory Ride.fromMap(Map<String, dynamic> map) {
    return Ride(
      user: map['user'].toString(),
      driver: map['driver'].toString(),
      pickupLocation: map['pickup_location'].toString(),
      destinationLocation: map['destination_location'].toString(),
      distance: map['distance'] is double
          ? map['distance']
          : double.parse(map['distance'].toString()),
      typeOfRide: map['type_of_ride'].toString(),
      baseFare: map['base_fare'] is double
          ? map['base_fare']
          : double.parse(map['base_fare'].toString()),
      totalReceived: map['total_received'] is double
          ? map['total_received']
          : double.parse(map['total_received'].toString()),
      completed: map['completed'] is bool
          ? map['completed']
          : map['completed'].toString() == 'true',
      date: DateTime.parse(map['date']),
      sharedWithFriends: List<MyUser>.from(map['shared_with_friends'] ?? []),
    );
  }
}
