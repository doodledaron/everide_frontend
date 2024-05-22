import 'package:everide_frontend/src/models/my_user_model.dart';
import 'package:everide_frontend/src/widgets/friend_list.dart';
import 'package:flutter/material.dart';

// import '../constants/app_contants.dart';
// import '../constants/colors.dart';

class RideDetailsCard extends StatelessWidget {
  final Map<String, dynamic> rideInfo;
  const RideDetailsCard({
    super.key,
    required this.rideInfo,
  });

  @override
  Widget build(BuildContext context) {
    final carPoolers = rideInfo['carpool']; // get the carpoolers
    final String destination = rideInfo['destination'];
    final String destinationAddress = rideInfo['destination address'];
    final String date = rideInfo['date'];
    final String pickUpLocation = rideInfo['Pickup location'];
    final String paymentMethod = rideInfo['Payment method'];

    if (carPoolers == null) {
      throw Exception(
          'Carpoolers data is null. Check that is carpoolers assign to that particular booking history');
    }
    final carPoolersNames = carPoolers
        .map((user) => user.username)
        .toList(); //map each user and get the username

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
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          destinationAddress,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Spacer(),
              Divider(
                color: Colors.grey[200],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: ${rideInfo['date']}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Pickup location: ${rideInfo['Pickup location']}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Fare: RM69.69 (static)',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Payment method: ${rideInfo['Payment method']}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Divider(
                color: Colors.grey[200],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Eve-squad:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FriendList(friendNameList: carPoolersNames),
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
