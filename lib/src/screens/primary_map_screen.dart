import 'dart:async';
import 'package:everide_frontend/src/constants/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey,
                                        backgroundImage:
                                            AssetImage('assets/billie.jpeg'),
                                      ),
                                      Text('Sample Name'),
                                      Divider(
                                        color: Colors.grey[500],
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.navigate_next,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    )
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
