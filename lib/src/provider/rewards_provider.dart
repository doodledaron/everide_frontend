import 'package:flutter/material.dart';

import '../models/reward_model.dart';

class RewardsProvider with ChangeNotifier {
  final List<Reward> rewards = [
    Reward(
      title: 'Everide Wallet Credit RM5',
      amountNeeded: '8500 CF',
    ),
    Reward(
      title: 'Everide Wallet Credit RM8',
      amountNeeded: '170,000 CF',
    ),
    Reward(
      title: 'Everide Wallet Credit RM10',
      amountNeeded: '340,000 CF',
    ),
    Reward(
      title: 'Everide Wallet Credit RM20',
      amountNeeded: '600,000 CF',
    ),
  ];
  List<Reward> get rewardsList => rewards;
}
