import 'package:google_maps_flutter/google_maps_flutter.dart';

class Driver {
  final int id;
  final String name;
  final String carModel;
  final String plateNumber;
  final double rating;
  final bool available;
  final int serviceDurationYear;
  final String currentLongitude;
  final String currentLatitude;

  Driver({
    required this.id,
    required this.name,
    required this.carModel,
    required this.plateNumber,
    required this.rating,
    required this.available,
    required this.serviceDurationYear,
    required this.currentLongitude,
    required this.currentLatitude,
  });

  LatLng get currentLocation => LatLng(
        double.parse(currentLatitude),
        double.parse(currentLongitude),
      );

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      name: json['name'],
      carModel: json['car_model'],
      plateNumber: json['plate_number'],
      rating: json['rating'].toDouble(),
      available: json['available'],
      serviceDurationYear: json['service_duration_year'],
      currentLongitude: json['current_longtidue'],
      currentLatitude: json['current_latitude'],
    );
  }
}
