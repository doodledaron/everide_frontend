import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/provider/ride_provider.dart';
import 'package:everide_frontend/src/provider/user_provider.dart';
import 'package:everide_frontend/src/widgets/history_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ViewMoreHistoryScreen extends StatefulWidget {
  const ViewMoreHistoryScreen({super.key});

  @override
  State<ViewMoreHistoryScreen> createState() => _ViewMoreHistoryScreenState();
}

class _ViewMoreHistoryScreenState extends State<ViewMoreHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    //ride provider will be passed here
    final rides = Provider.of<RideProvider>(context).rides;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text('Ride history'),
      ),
      body: ListView.builder(
          itemCount: rides.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(
                Icons.location_on,
                color: primaryColor,
              ),
              title: Text(
                rides[index].destination_location,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
          }),
    );
  }
}
