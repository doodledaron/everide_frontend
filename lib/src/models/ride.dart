import 'dart:ffi';

class Ride {
  int user;
  String driver;
  String pickup_location;
  String destination;
  Float base_fare;
  Float extra_tips;
  Float total_received;
  bool completed;
  DateTime date;
  List<dynamic> shared_with_friends;

  Ride(
      {required this.user,
      required this.driver,
      required this.pickup_location,
      required this.destination,
      required this.base_fare,
      required this.extra_tips,
      required this.total_received,
      required this.completed,
      required this.date,
      required this.shared_with_friends});

  Ride copyWith({
    int? user,
    String? driver,
    String? pickup_location,
    String? destination,
    Float? base_fare,
    Float? extra_tips,
    Float? total_received,
    bool? completed,
    DateTime? date,
    List<String>? shared_with_friends,
  }) {
    return Ride(
      user: user ?? this.user,
      driver: driver ?? this.driver,
      pickup_location: pickup_location ?? this.pickup_location,
      destination: destination ?? this.destination,
      base_fare: base_fare ?? this.base_fare,
      extra_tips: extra_tips ?? this.extra_tips,
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
      'destination': destination,
      'base_fare': base_fare,
      'extra_tips': extra_tips,
      'total_received': total_received,
      'completed': completed,
      'date': date,
      'shared_with_friends': shared_with_friends,
    };
  }

  factory Ride.fromMap(Map<String, dynamic> map) {
    return Ride(
      user: map['user'],
      driver: map['driver'],
      pickup_location: map['pickup_location'],
      destination: map['destination'],
      base_fare: map['base_fare'],
      extra_tips: map['extra_tips'],
      total_received: map['total_received'],
      completed: map['completed'],
      date: map['date'],
      shared_with_friends: map['shared_with_friends'],
    );
  }
}

class BookingHistory {
  int id;
  String user;
  String ride;

  BookingHistory({required this.id, required this.user, required this.ride});

  BookingHistory copyWith({
    int? id,
    String? user,
    String? ride,
  }) {
    return BookingHistory(
      id: id ?? this.id,
      user: user ?? this.user,
      ride: ride ?? this.ride,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'ride': ride,
    };
  }

  factory BookingHistory.fromMap(Map<String, dynamic> map) {
    return BookingHistory(
      id: map['id'],
      user: map['user'],
      ride: map['ride'],
    );
  }
}
