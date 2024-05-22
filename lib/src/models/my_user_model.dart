class MyUser {
  String id;
  String username;
  String email;
  String password;
  String phoneNumber;
  String profilePicture;
 
  List<MyUser> friends;

  MyUser({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.profilePicture,
    
    required this.friends,
  });
}
