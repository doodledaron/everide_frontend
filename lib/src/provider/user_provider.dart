import 'package:flutter/material.dart';

import '../models/user.dart';
import '../utils/services/user_services.dart';

class UserProvider extends ChangeNotifier {
  final _service = UserService();
  bool isLoading = false;
  List<MyUser> _users = [];
  List<MyUser> get users => _users;

  Future<void> getAllUser() async {
    isLoading = true;
    notifyListeners();

    _users = (await _service.getAll()).cast<MyUser>();

    isLoading = false;
    notifyListeners();
  }
}
