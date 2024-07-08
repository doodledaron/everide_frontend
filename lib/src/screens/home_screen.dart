import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:everide_frontend/src/constants/app_contants.dart';
import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/provider/user_provider.dart';
import 'package:everide_frontend/src/widgets/saved_carbon_big_card.dart';
import '../provider/ride_provider.dart';
import '../widgets/buttons/everide_button.dart';
import '../widgets/history_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int historyDisplayLimit = 7;

  @override
  void initState() {
    super.initState();
    // Fetch user data in initState, so it only fetches once when app initializes
    // Make sure listen: false is set
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchAllUser();
      Provider.of<RideProvider>(context, listen: false).getAllRide();
      // Provider.of<BookingHistoryProvider>(context, listen: false)
      //     .getAllBookingHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        forceMaterialTransparency: true,
        title: userProvider.isLoading
            ? const SizedBox()
            : userProvider.user != null
                ? Row(
                    children: [
                      Text('Hi ${userProvider.user!.username}'),
                    ],
                  )
                : const Text('Hi Guest'),
      ),
      drawer: Drawer(
        child: ListView(
          // Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: backgroundColor,
              ),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/everide_logo.jpg',
                    width: 70,
                  ),
                  const Text(
                    'Everride',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              )),
            ),
            ListTile(
              title: const Text(
                'Eve-Wallet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                context.pushNamed('wallet');
              },
            ),
            ListTile(
              title: const Text(
                'View your rewards',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
                context.pushNamed('rewards');
              },
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        // Display a loading indicator if data is being fetched, otherwise show content
        child: userProvider.isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  children: [
                    const SavedCarbonBigCard(carbonValue: 68),
                    const SizedBox(height: 25),
                    const EverideButton(),
                    const SizedBox(height: 25),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15),
                              child: Text(
                                'Ever wonder your history?',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800),
                              ),
                            ),
                            Expanded(
                              child: HistoryListWidget(
                                  historyDisplayLimit: historyDisplayLimit),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
      ),
    );
  }
}
