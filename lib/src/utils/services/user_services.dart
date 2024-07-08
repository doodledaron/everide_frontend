import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/api_path.dart';
import '../../models/carbon_footprint_model.dart';
import '../../models/my_user_model.dart';

class UserService {
  Future<List<MyUser>> getAll() async {
    final uri = Uri.parse('${api}user/');

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

  //TODO get friends based on id in the friends list
  Future<List<MyUser>> getUserFriends(String id) async {
    final url = Uri.parse('${api}user/$id/friends/');
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        try {
          final List<dynamic> json = jsonDecode(res.body);
          final friendList =
              json.map((myuser) => MyUser.fromMap(myuser)).toList();
          return friendList;
        } catch (e) {
          throw Exception('Failed to parse users: $e');
        }
      } else {
        throw Exception(
            'Failed to load users, status code: ${res.statusCode}, body: ${res.body}');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<CarbonFootprint> getCarbonFootprint(String id) async {
    final url = Uri.parse('$api/carbon_footprint/$id/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> json = jsonDecode(response.body)[0];
          final carbonFootprint = CarbonFootprint.fromJson(json);
          return carbonFootprint;
        } catch (e) {
          throw Exception('Failed to parse users: $e');
        }
      } else {
        throw Exception(
            'Failed to load users, status code: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
