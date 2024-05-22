
import 'package:everide_frontend/src/provider/ride_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';

class HistoryListWidget extends StatelessWidget {
  const HistoryListWidget({
    super.key,
    
    required this.historyDisplayLimit,
  });

  final int historyDisplayLimit;

  @override
  Widget build(BuildContext context) {
    final rides = Provider.of<RideProvider>(context).rides;
    return ListView.builder(
      itemCount: rides.length > historyDisplayLimit
          ? historyDisplayLimit + 1
          : rides.length,
      itemBuilder: (context, index) {
        
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
            rides[index].destination_location,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          subtitle: const Text(
           '241, Petronas Twin Tower, Kuala Lumpur City Centre, 50088 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur',
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
