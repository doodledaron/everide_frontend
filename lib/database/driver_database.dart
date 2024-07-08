import '../src/models/driver_model.dart';

class DriverDatabase {
  final List<Driver> drivers = [
    Driver(
      id: 1,
      name: 'John Doe',
      carModel: 'Proton X70',
      plateNumber: 'WQD 1234',
      rating: 4.5,
      available: true,
      serviceDurationYear: 2,
      currentLongitude: "101.519730",
      currentLatitude: "3.128140",
    ),
    Driver(
      id: 2,
      name: 'Jane Doe',
      carModel: 'Perodua Myvi',
      plateNumber: 'WQD 5678',
      rating: 4.0,
      available: false,
      serviceDurationYear: 1,
      currentLongitude: "101.613937",
      currentLatitude: "3.012930",
    ),
    Driver(
      id: 3,
      name: 'John Smith',
      carModel: 'Proton Saga',
      plateNumber: 'WQD 9876',
      rating: 4.2,
      available: true,
      serviceDurationYear: 3,
      currentLongitude: "101.697100",
      currentLatitude: "3.153400",
    ),
  ];
}
