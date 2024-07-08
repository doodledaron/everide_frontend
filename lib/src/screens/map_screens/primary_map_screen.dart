import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/models/my_user_model.dart';
import 'package:everide_frontend/src/provider/google_map_service_provider.dart';
import 'package:everide_frontend/src/provider/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../widgets/friend_list.dart';

class PrimaryMapScreen extends StatefulWidget {
  const PrimaryMapScreen({super.key});

  @override
  State<PrimaryMapScreen> createState() => _PrimaryMapScreenState();
}

class _PrimaryMapScreenState extends State<PrimaryMapScreen> {
  late GoRouter router;
  GoogleMapServiceProvider? _googleMapServiceProvider; // to be later saved
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async =>
        await Provider.of<GoogleMapServiceProvider>(context, listen: false)
            .initializeCurrentLocationUpdates());
  }

//Since Provider cannot be directly accessed in the dispose method, you use didChangeDependencies to save a reference to the provider instance. This reference can then be used in the dispose method to perform cleanup tasks.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //save a reference,coz Provider cant be used in the dispose() method
    _googleMapServiceProvider =
        Provider.of<GoogleMapServiceProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _googleMapServiceProvider?.cancelCurrentLocationUpdates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final List<MyUser> friendList = Provider.of<UserProvider>(context).userFriendList;

    final currentPosition =
        Provider.of<GoogleMapServiceProvider>(context).currentPosition;
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //TODO print the recent friend here
                        FriendList(
                          friendNameList: friendList,
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                    const SizedBox(
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
                          context.pushNamed('choosedestination',
                              extra: currentPosition);
                          Provider.of<GoogleMapServiceProvider>(context,
                                  listen: false)
                              .cancelCurrentLocationUpdates();
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
                  target: currentPosition,
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('currentLocation'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: currentPosition,
                  ),
                },
              ),
            ),
    );
  }
}
