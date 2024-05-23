import 'package:everide_frontend/src/constants/colors.dart';
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
    final user = Provider.of<UserProvider>(context).user;
    final bookingHistoryList = user.bookingHistory;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text('Ride history'),
      ),
      body: ListView.builder(
          itemCount: bookingHistoryList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(
                Icons.location_on,
                color: primaryColor,
              ),
              title: Text(
                bookingHistoryList[index]['destination']!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                bookingHistoryList[index]['destination address']!,
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
