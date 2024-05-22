import 'package:everide_frontend/src/provider/google_map_service_provider.dart';
import 'package:everide_frontend/src/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../constants/colors.dart';
import '../widgets/buttons/pick_me_up_button.dart';

class ChoosePickUpPointScreen extends StatefulWidget {
  const ChoosePickUpPointScreen({super.key});

  @override
  State<ChoosePickUpPointScreen> createState() =>
      _ChoosePickUpPointScreenState();
}

class _ChoosePickUpPointScreenState extends State<ChoosePickUpPointScreen> {
  LatLng? currentPosition;
  int _selectedIndex = -1;
  final PanelController _panelController = PanelController();
  @override
  void initState() {
    super.initState();
    currentPosition =
        Provider.of<GoogleMapServiceProvider>(context, listen: false)
            .currentPosition;
    Provider.of<GoogleMapServiceProvider>(context, listen: false)
        .fetchNearbyPlacesFromCurrentLocation(currentPosition!);
  }

  void updateCurrentPosition(double lat, double lng) {
    setState(() {
      currentPosition = LatLng(lat, lng);
    });
  }

  void setThePickUpLocation(Map<String, dynamic> pickup) {
    Provider.of<GoogleMapServiceProvider>(context, listen: false)
        .saveSelectedPickUpLocation(pickup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your pick up'),
      ),
      body: currentPosition == null
          ? const Center(child: CustomLoadingIndicator())
          : Consumer<GoogleMapServiceProvider>(
              builder: ((context, provider, child) {
                return SlidingUpPanel(
                  controller: _panelController,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  minHeight: 250,
                  maxHeight: 400,
                  panel: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'EV Pick-up Point',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                provider.nearbyPlacesFromCurrentLocation.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: _selectedIndex == index
                                        ? const Color.fromARGB(
                                            48, 109, 172, 169)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(25)),
                                child: ListTile(
                                  splashColor: backgroundColor,
                                  onTap: () async {
                                    setState(() {
                                      _selectedIndex =
                                          index; // Update the selected index
                                    });
                                    final lat = provider
                                            .nearbyPlacesFromCurrentLocation[
                                        index]['latitude'];
                                    final lng = provider
                                            .nearbyPlacesFromCurrentLocation[
                                        index]['longitude'];
                                    // Ensure the panel is attached and then open it
                                    // Ensure the panel is attached and then open it
                                    await Future.delayed(
                                        const Duration(milliseconds: 100));
                                    if (_panelController.isAttached) {
                                      _panelController.open();
                                    } else {
                                      print('Panel controller is not attached');
                                    }
                                    //save pick up location
                                    setThePickUpLocation(provider
                                            .nearbyPlacesFromCurrentLocation[
                                        index]);
                                    updateCurrentPosition(lat, lng);
                                  },
                                  leading: const Icon(
                                    Icons.location_on,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    provider.nearbyPlacesFromCurrentLocation[
                                        index]['name'],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    provider.nearbyPlacesFromCurrentLocation[
                                        index]['des'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: GreenButton(
                            onPressed: () {
                              context.pushNamed("ordersummary");
                            },
                            text: 'Pick me up!',
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
                );
              }),
            ),
    );
  }
}
