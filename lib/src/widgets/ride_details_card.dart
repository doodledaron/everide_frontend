import 'package:everide_frontend/src/models/my_user_model.dart';
import 'package:everide_frontend/src/widgets/friend_list.dart';
import 'package:flutter/material.dart';

import '../constants/app_contants.dart';
import '../constants/colors.dart';
import '../models/ride.dart';

// import '../constants/app_contants.dart';
// import '../constants/colors.dart';

class RideDetailsCard extends StatelessWidget {
  final Ride ride;
  const RideDetailsCard({
    super.key,
    required this.ride,
  });

  @override
  Widget build(BuildContext context) {
    final carPoolers = ride.shared_with_friends; // get the carpoolers
    final String destination = ride.destination_location;
    const String destinationAddress =
        '241, Petronas Twin Tower, Kuala Lumpur City Centre, 50088 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur';
    final String date = ride.date.toString();
    final String pickUpLocation = ride.pickup_location;
    const String paymentMethod = 'Card';
    final String totalPayment = ride.total_received.toString();

    if (carPoolers.isEmpty) {
      throw Exception(
          'Carpoolers data is null. Check that is carpoolers assign to that particular booking history');
    }

    // final carPoolersNames = carPoolers
    //     .map((user) => user.username)
    //     .toList(); //map each user and get the username

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kBorderRadiusCards),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          destination,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: const Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          destinationAddress,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              Divider(
                color: Colors.grey[200],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: $date',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Pickup location: $pickUpLocation',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Fare: $totalPayment',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Payment method: Card',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Divider(
                color: Colors.grey[200],
              ),
              const Spacer(),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Eve-squad:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FriendList(friendNameList: []),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
