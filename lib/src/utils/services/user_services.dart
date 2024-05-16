import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constants/api_path.dart';
import '../../models/user.dart';

class UserService {
  Future<List<User>> getAll() async {
    const url = '${api}user/';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final user = json.map((e) {
        return User(
          id: e['id'],
          username: e['username'],
          email: e['email'],
          password: e['password'],
          phoneNumber: e['phoneNumber'],
          profilePicture: e['profilePicture'],
          friends: e['friends'],
        );
      }).toList();
      return user;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
