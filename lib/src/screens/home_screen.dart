import 'package:everide_frontend/src/constants/app_contants.dart';
import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/models/ride.dart';
import 'package:everide_frontend/src/provider/ride_provider.dart';
import 'package:everide_frontend/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    });
    // Provider.of<UserProvider>(context, listen: false).getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final ride = Provider.of<RideProvider>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        //loading == true? loading, else show your widget
        child: user.isLoading
            ? const CircularProgressIndicator()
            : //test your widgets here
            Consumer<UserProvider>(
                builder: (context, user, child) {
                  return ListView.builder(
                    itemCount: user.users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(user.users[index].username),
                        subtitle: Text(user.users[index].friends.toString()),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
