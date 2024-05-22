import 'package:flutter/material.dart';

import '../models/my_user_model.dart';
import '../utils/services/user_services.dart';

class UserProvider extends ChangeNotifier {
  final _service = UserService();
  bool isLoading = false;
  List<MyUser> _users = [];
  List<MyUser> get users => _users;
  MyUser get user => _users[0];

  Future<void> fetchAllUser() async {
    isLoading = true;
    notifyListeners();

    _users = (await _service.getAll()).cast<MyUser>();

    isLoading = false;
    notifyListeners();
  }
}
