import 'package:everide_frontend/src/constants/app_contants.dart';
import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/provider/user_provider.dart';
import 'package:everide_frontend/src/screens/add_carpooler_screen.dart';
import 'package:everide_frontend/src/widgets/fun_fact_card.dart';
import 'package:everide_frontend/src/widgets/saved_carbon_big_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/buttons/everide_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
//leonnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
//test your widgets here
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //fetch user data in initState, so it only fetches one day when app initialized
    //You can only write above code with listen: false if you are writing it inside initState(). By setting listen: false you tell not to rebuild the widget upon data changes happen inside the provider.
    //we only have to do it once here to set our user, then other screens can just access it
    Provider.of<UserProvider>(context, listen: false).fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: user.loading
            ? SizedBox()
            : Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/billie.jpeg'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Hi ${user.user.username}'),
                ],
              ),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        //loading == true? loading, else show your widget
        child: user.loading
            ? const CircularProgressIndicator()
            : //test your widgets here
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  children: [
                    SavedCarbonBigCard(carbonValue: 68),
                    SizedBox(
                      height: 25,
                    ),
                    EverideButton(),
                    SizedBox(
                      height: 25,
                    ),
                    Placeholder()
                  ],
                ),
              ),
      ),
    );
  }
}
