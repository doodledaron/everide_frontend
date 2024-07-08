import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/provider/ride_provider.dart';
import 'package:everide_frontend/src/widgets/ride_details_card.dart';
import 'package:everide_frontend/src/widgets/saved_carbon_big_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideDetailScreen extends StatelessWidget {
  final int index;
  const RideDetailScreen({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    //Ride provider will be used later
    //temporarily pass in index
    final rideInfo = Provider.of<RideProvider>(context).rides[
        index]; //get the ride info based on the index of previous screen
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Ride details'),
        forceMaterialTransparency: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SavedCarbonBigCard(carbonValue: 70),
            const SizedBox(
              height: 25,
            ),
            RideDetailsCard(
              ride: rideInfo,
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
