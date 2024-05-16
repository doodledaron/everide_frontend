import 'package:flutter/material.dart';

import '../utils/services/user_services.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final _service = UserService();
  bool isLoading = false;
  List<User> _users = [];
  List<User> get users => _users;

  Future<void> getAllUser() async {
    isLoading = true;
    notifyListeners();

    _users = await _service.getAll();

    isLoading = false;
    notifyListeners();
  }
}
