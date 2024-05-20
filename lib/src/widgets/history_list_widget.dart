import 'package:everide_frontend/src/models/my_user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/colors.dart';


class HistoryListWidget extends StatelessWidget {
  const HistoryListWidget({
    super.key,
    required this.user,
    required this.historyDisplayLimit,
  });

  final MyUser user;
  final int historyDisplayLimit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: user.bookingHistory.length > historyDisplayLimit
          ? historyDisplayLimit + 1
          : user.bookingHistory.length,
      itemBuilder: (context, index) {
        final List<Map<String, dynamic>> historyList = user.bookingHistory;
        if (index == historyDisplayLimit) {
          return TextButton(
            onPressed: () {
              context.pushNamed('viewmorehistory');
            },
            child: const Text(
              'View More',
              style:
                  TextStyle(color: highlightColor, fontWeight: FontWeight.bold),
            ),
          );
        }
        return ListTile(
          leading: const Icon(
            Icons.location_on,
            color: primaryColor,
          ),
          title: Text(
            historyList[index]['destination']!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            historyList[index]['destination address']!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () {
              context.pushNamed('ridedetails', extra: index);
            },
            icon: const Icon(
              Icons.navigate_next,
              color: primaryColor,
            ),
          ),
        );
      },
    );
  }
}
