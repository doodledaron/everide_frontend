import 'dart:async';
import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/models/my_user_model.dart';
import 'package:everide_frontend/src/provider/user_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../constants/app_contants.dart';
import '../widgets/friend_list.dart';

class PrimaryMapScreen extends StatefulWidget {
  const PrimaryMapScreen({super.key});

  @override
  State<PrimaryMapScreen> createState() => _PrimaryMapScreenState();
}

class _PrimaryMapScreenState extends State<PrimaryMapScreen> {
  final locationController = Location();

  LatLng? currentPosition; // will be used to store the current location of user
  late StreamSubscription<LocationData> locationSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await initializeMap());
  }

  Future<void> initializeMap() async {
    await fetchLocationUpdates(); //fetch the
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locationSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final List<MyUser> friendList = user.friends;
    final List<String> friendNameList =
        friendList.map((e) => e.username).toList();
    print(friendNameList);
    return Scaffold(
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : SlidingUpPanel(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              minHeight: 250,
              maxHeight: 250,
              panel: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fancy a carpool?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Recent carpool-ers',
                      style: TextStyle(
                          fontWeight: FontWeight.w100, color: Colors.black54),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FriendList(
                          friendNameList: friendNameList,
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        IconButton(
                          iconSize: 40,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.navigate_next,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Material(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        splashColor: primaryColor,
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          //the user wont able to navigate back
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Spacer(),
                                Text(
                                  'Destination',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Spacer(
                                  flex: 7,
                                ),
                                Icon(
                                  Icons.search,
                                  color: Colors.black45,
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: currentPosition!,
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('currentLocation'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: currentPosition!,
                  ),
                },
              ),
            ),
    );
  }

//will be invoked in initState - get current location
  Future<void> fetchLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    //check if service is enabled
    serviceEnabled = await locationController.serviceEnabled();
    if (!serviceEnabled) {
      //request for the service
      serviceEnabled = await locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    //check if permission is granted
    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      //prompt the user to allow the app access to the location
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        //if not allow, exit
        return;
      }
    }

    //listen to location changes
    //assign the location controller to the subscription so that we can dispose it later
    locationSubscription = locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        //update the current location which can bu used later to display the marker
        setState(() {
          currentPosition =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        print(currentLocation);
      }
    });
  }
}
