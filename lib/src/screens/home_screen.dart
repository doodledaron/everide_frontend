import 'package:everide_frontend/src/constants/app_contants.dart';
import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/models/ride.dart';
import 'package:everide_frontend/src/provider/booking_history_provider.dart';
import 'package:everide_frontend/src/provider/ride_provider.dart';
import 'package:everide_frontend/src/screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//test your widgets here
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //fetch user data in initState, so it only fetches one day when app initialized
    //You can only write above code with listen: false if you are writing it inside initState(). By setting listen: false you tell not to rebuild the widget upon data changes happen inside the provider.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).getAllUser();
      Provider.of<RideProvider>(context, listen: false).getAllRide();
      Provider.of<BookingHistoryProvider>(context, listen: false)
          .getAllBookingHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final ride = Provider.of<RideProvider>(context);
    final booking_history = Provider.of<BookingHistoryProvider>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
          //loading == true? loading, else show your widget
          child: user.isLoading
              ? const CircularProgressIndicator()
              : //test your widgets here
              // WalletScreen(),
              // Consumer<RideProvider>(
              //     builder: (context, user, child) {
              //       return ListView.builder(
              //         itemCount: ride.rides.length,
              //         itemBuilder: (context, index) {
              //           return ListTile(
              //             leading: Text(ride.rides[index].user),
              //             title: Text(ride.rides[index].pickup_location),
              //             subtitle: Text(
              //                 ride.rides[index].shared_with_friends.toString()),
              //           );
              //         },
              //       );
              //     },
              //   ),
              Consumer<BookingHistoryProvider>(
                  builder: (context, booking_history, child) {
                  return ListView.builder(
                    itemCount: booking_history.bookingHistories.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:
                            Text(booking_history.bookingHistories[index].user),
                        subtitle: Text(booking_history
                            .bookingHistories[index].pickup_location),
                      );
                    },
                  );
                })
          // Consumer<UserProvider>(
          //     builder: (context, user, child) {
          //       return ListView.builder(
          //         itemCount: user.users.length,
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             title: Text(user.users[index].username),
          //             subtitle: Text(user.users[index].email),
          //           );
          //         },
          //       );
          //     },
          //   ),
          ),
    );
  }
}
