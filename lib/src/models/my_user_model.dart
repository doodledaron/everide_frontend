class MyUser {
  String id;
  String username;
  String email;
  String password;
  String phoneNumber;
  String profilePicture;
  List<String> friends;

  MyUser({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.profilePicture,
    required this.friends,
  });

  MyUser copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? phoneNumber,
    String? profilePicture,
    List<String>? friends,
  }) {
    return MyUser(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      friends: friends ?? this.friends,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'friends': friends,

    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      phoneNumber: map['phoneNumber'],
      profilePicture: map['profilePicture'],
      friends: map['friends'],
    );
  }
}
