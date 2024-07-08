import 'package:everide_frontend/src/constants/app_contants.dart';
import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/provider/order_provider.dart';
import 'package:everide_frontend/src/provider/ride_provider.dart';
import 'package:everide_frontend/src/provider/user_provider.dart';
import 'package:everide_frontend/src/widgets/fun_fact_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCarpoolerScreen extends StatefulWidget {
  const AddCarpoolerScreen({super.key});

  @override
  State<AddCarpoolerScreen> createState() => _AddCarpoolerScreenState();
}

class _AddCarpoolerScreenState extends State<AddCarpoolerScreen> {
  List<dynamic> foundUsers = []; //temporary list to show the names
  bool showFriendList = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final rideProvider = Provider.of<RideProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final List<dynamic> allUser =
        user!.friends.map((friend) => friend).toList();
    final List<dynamic> allUserName = allUser.map((e) => e.username).toList();

// .map() is used for transforming elements.
// .where() is used for filtering elements based on a condition.
    runFilter(String enteredKeywords) {
      List<dynamic> results = [];
      if (enteredKeywords.isEmpty) {
        results = allUserName;
      } else {
        results = allUserName
            .where((user) =>
                user.toLowerCase().contains(enteredKeywords.toLowerCase()))
            .toList();
      }

      setState(() {
        foundUsers = results;
        showFriendList = enteredKeywords.isNotEmpty;
      });
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add car-poolers'),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) => runFilter(value),
                      decoration: const InputDecoration(
                        hintText: 'Everide now with friends',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(Icons.search),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const FunFactCard(),
            const SizedBox(
              height: 25,
            ),
            showFriendList
                ? Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(kBorderRadiusCards),
                      ),
                      child: ListView.builder(
                        itemCount: foundUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              //find the MyUser based on username string
                              final selectedUser = allUser.firstWhere(
                                  (element) =>
                                      element.username == foundUsers[index]);
                              try {
                                orderProvider.addCarPooler(selectedUser);
                                rideProvider.addFriend(selectedUser);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added carpooler!'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.toString()),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            title: Text(foundUsers[index]),
                          );
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
