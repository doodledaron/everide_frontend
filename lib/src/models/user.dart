// class MyUser {
//   String username;
//   String email;
//   String password;
//   String phoneNumber;
//   String profilePicture;
//   List<dynamic> friends;

//   MyUser(
//       {required this.username,
//       required this.email,
//       required this.password,
//       required this.phoneNumber,
//       required this.profilePicture,
//       required this.friends});

//   MyUser copyWith({
//     String? username,
//     String? email,
//     String? password,
//     String? phoneNumber,
//     String? profilePicture,
//     List<String>? friends,
//   }) {
//     return MyUser(
//       username: username ?? this.username,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       profilePicture: profilePicture ?? this.profilePicture,
//       friends: friends ?? this.friends,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'username': username,
//       'email': email,
//       'password': password,
//       'phoneNumber': phoneNumber,
//       'profilePicture': profilePicture,
//       'friends': friends,
//     };
//   }

//   factory MyUser.fromMap(Map<String, dynamic> map) {
//     return MyUser(
//       username: map['username'],
//       email: map['email'],
//       password: map['password'],
//       phoneNumber: map['phoneNumber'],
//       profilePicture: map['profilePicture'],
//       friends: map['friends'],
//     );
//   }
// }

// class Driver {
//   String name;
//   String carModel;
//   String plateNumber;
//   double rating;
//   bool active;
//   String serviceDuration;

//   Driver(
//       {required this.name,
//       required this.carModel,
//       required this.plateNumber,
//       required this.rating,
//       required this.active,
//       required this.serviceDuration});

//   Driver copyWith({
//     String? name,
//     String? carModel,
//     String? plateNumber,
//     double? rating,
//     bool? active,
//     String? serviceDuration,
//   }) {
//     return Driver(
//       name: name ?? this.name,
//       carModel: carModel ?? this.carModel,
//       plateNumber: plateNumber ?? this.plateNumber,
//       rating: rating ?? this.rating,
//       active: active ?? this.active,
//       serviceDuration: serviceDuration ?? this.serviceDuration,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'carModel': carModel,
//       'plateNumber': plateNumber,
//       'rating': rating,
//       'active': active,
//       'serviceDuration': serviceDuration,
//     };
//   }

//   factory Driver.fromMap(Map<String, dynamic> map) {
//     return Driver(
//       name: map['name'],
//       carModel: map['carModel'],
//       plateNumber: map['plateNumber'],
//       rating: map['rating'],
//       active: map['active'],
//       serviceDuration: map['serviceDuration'],
//     );
//   }
// }
