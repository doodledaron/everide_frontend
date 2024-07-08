
import 'package:flutter/material.dart';

import '../models/my_user_model.dart';
import '../utils/services/user_services.dart';

class UserProvider extends ChangeNotifier {
  final _service = UserService();
  bool isLoading = false;
  MyUser? loggedInUser;
  List<MyUser> _users = [];
  List<MyUser> get users => _users;
  MyUser? get user => _users.isNotEmpty ? _users[0] : null;
  List<MyUser> userFriendList = [];

  Future<void> fetchAllUser() async {
    isLoading = true;
    notifyListeners();

    try {
      _users = (await _service.getAll()).cast<MyUser>();
      loggedInUser = _users[0];
      //get the friend list if not empty
      if (loggedInUser!.friends.isNotEmpty) {
          userFriendList = await _service.getUserFriends(loggedInUser!.id);
      }
      
    } catch (error) {
      // Handle the error here
      print('Error fetching users: $error');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners that loading ended
    }

    notifyListeners();
  }

  Future<void> getCarbonFootprint() async {
    isLoading = true;
    notifyListeners();
    try {} catch (e) {
      print('Error getting carbon footprint: $e');
    }
    isLoading = false;
    notifyListeners();
  }
}
