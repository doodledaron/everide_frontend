import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/api_path.dart';
import '../../models/my_user_model.dart';

class UserService {
  Future<List<MyUser>> getAll() async {
    const url = '${api}user/';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        try {
          final List<dynamic> json = jsonDecode(response.body);
          final users = json.map((e) {
            return MyUser(
              id: e['id']?.toString() ?? '',
              username: e['username']?.toString() ?? '',
              email: e['email']?.toString() ?? '',
              password: e['password']?.toString() ?? '',
              phoneNumber: e['phoneNumber']?.toString() ?? '',
              profilePicture: e['profilePicture']?.toString() ?? '',
              friends: [],
            );
          }).toList();
          return users;
        } catch (e) {
          throw Exception('Failed to parse users: $e');
        }
      } else {
        // Log the response body and headers for more insights
        print('Response status: ${response.statusCode}');
        print('Response headers: ${response.headers}');
        print('Response body: ${response.body}');
        throw Exception(
            'Failed to load users, status code: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
