import 'package:flutter/material.dart';

import '../models/my_user_model.dart';

class OrderProvider with ChangeNotifier {
  List<MyUser> carpooler = [];

  void addCarPooler(MyUser user) {
    if (!carpooler.contains(user)) {
      carpooler.add(user);
      notifyListeners();
    } else {
      throw Exception('User already added');
    }
  }
}
