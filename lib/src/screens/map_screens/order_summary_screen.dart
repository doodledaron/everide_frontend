import 'package:everide_frontend/src/provider/driver_provider.dart';
import 'package:everide_frontend/src/provider/order_provider.dart';
import 'package:everide_frontend/src/provider/ride_provider.dart';
import 'package:everide_frontend/src/widgets/buttons/pick_me_up_button.dart';
import 'package:everide_frontend/src/widgets/custom_loading_indicator.dart';

import 'package:everide_frontend/src/widgets/friend_list.dart';
import 'package:everide_frontend/src/widgets/popups/driver_found_popup.dart';
import 'package:everide_frontend/src/widgets/popups/finding_driver_popup.dart';
import 'package:everide_frontend/src/widgets/ride_payment_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../constants/colors.dart';
import '../../models/my_user_model.dart';
import '../../provider/google_map_service_provider.dart';
import '../../utils/distance_calculator.dart';

import 'package:delightful_toast/delight_toast.dart';

import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

//calculate distance between user and driver
LatLng findNearestDriver(LatLng userLocation, List<LatLng> drivers) {
  double minDistance = double.infinity;
  LatLng nearestDriver = drivers[0];
  for (LatLng driver in drivers) {
    double distance = calculateDistance(userLocation.latitude,
        userLocation.longitude, driver.latitude, driver.longitude);
    if (distance < minDistance) {
      minDistance = distance;
      nearestDriver = driver;
    }
  }
  return nearestDriver;
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  bool? _isCarPoolListEmpty;
  double? price;
  double? totalDistance;
  List<LatLng>? mockDrivers;
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeMap();
    });
  }

  Future<void> initializeMap() async {
    final googleMapProvider =
        Provider.of<GoogleMapServiceProvider>(context, listen: false);
    final driverProvider = Provider.of<DriverProvider>(context, listen: false);
    driverProvider.loadDrivers();
    mockDrivers = driverProvider.driverLatLng;
    final LatLng pickUpLatLng = getLatLngFromProvider(context, 'pickup');
    final LatLng destinationLatLng =
        getLatLngFromProvider(context, 'destination');
    Marker pickUpMarker = Marker(
      markerId: const MarkerId('currentLocation'),
      icon: BitmapDescriptor.defaultMarker,
      position: pickUpLatLng,
    );
    Marker destinationMarker = Marker(
      markerId: const MarkerId('destinationLocation'),
      icon: BitmapDescriptor.defaultMarker,
      position: destinationLatLng,
    );
    setState(() {
      markers.add(pickUpMarker);
      markers.add(destinationMarker);
    });
    await googleMapProvider.fetchPolylinePoints(pickUpLatLng, destinationLatLng,
        true); // Get the polyline between the source and destination locations
    generatePolyLineFromPoints(googleMapProvider
        .coordinatesFromUserToDestination!); // Draw the polyline
    //calculate the distance
    totalDistance = calculateDistance(
            pickUpLatLng.latitude,
            pickUpLatLng.longitude,
            destinationLatLng.latitude,
            destinationLatLng.longitude) +
        5;

    price = calculatePrice(totalDistance!);

    //update the ride
    final rideProvider = Provider.of<RideProvider>(context, listen: false);
    rideProvider.updateDistance(totalDistance!);
    rideProvider.updateTotalReceived(price!);
    final newDate = DateTime.now();
    rideProvider.updateDate(newDate);
  }

  void moveDriverMarkerAlongPolyline(Marker driverMarker,
      List<LatLng> polylinePoints, bool isReachedDestination) async {
    int totalSteps = polylinePoints.length;
    int stepDuration = const Duration(seconds: 3).inMilliseconds ~/ totalSteps;

    for (LatLng point in polylinePoints) {
      setState(() {
        markers
            .removeWhere((marker) => marker.markerId == driverMarker.markerId);
        driverMarker = driverMarker.copyWith(
          positionParam: point,
        );
        markers.add(driverMarker);
      });
      await Future.delayed(Duration(milliseconds: stepDuration));
    }
    if (mounted) {
      DelightToastBar(
        autoDismiss: true,
        position: DelightSnackbarPosition.top,
        builder: (context) => ToastCard(
          leading: const Icon(
            Icons.energy_savings_leaf_rounded,
            size: 28,
          ),
          title: Text(
            isReachedDestination
                ? "Beep beep! Your driver has arrived at your location!"
                : "Yey! Your driver has reached!",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ).show(context);
    }
  }

  Future<void> generatePolyLineFromPoints(
      List<LatLng> polylineCoordinates) async {
    const id = PolylineId('polyline');

    final polyline = Polyline(
      polylineId: id,
      color: primaryColor,
      points: polylineCoordinates,
      width: 5,
    );

    setState(() => polylines[id] = polyline);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<MyUser> carPoolerList = getCarpooler(context);
    _isCarPoolListEmpty = carPoolerList.isEmpty;

    final LatLng pickUpLatLng = getLatLngFromProvider(context, 'pickup');
    final LatLng destinationLatLng =
        getLatLngFromProvider(context, 'destination');

    return Scaffold(
      body: (price != null && totalDistance != null)
          ? SlidingUpPanel(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              minHeight: MediaQuery.of(context).size.height * 0.4,
              maxHeight: MediaQuery.of(context).size.height * 0.5,
              panel: _buildPanelContent(carPoolerList),
              body: _buildGoogleMap(pickUpLatLng, destinationLatLng),
            )
          : const Center(
              child: CustomLoadingIndicator(),
            ),
    );
  }

  List<MyUser> getCarpooler(BuildContext context) {
    // final List<MyUser> carPoolerList =
    //     Provider.of<OrderProvider>(context).carpooler;
    final List<MyUser> carPoolerList =
        Provider.of<RideProvider>(context).sharedWithFriends;
    return carPoolerList;
  }

  LatLng getLatLngFromProvider(BuildContext context, String type) {
    final provider =
        Provider.of<GoogleMapServiceProvider>(context, listen: false);
    final Map<String, dynamic> location = type == 'pickup'
        ? provider.selectedPickUpLocation
        : provider.selectedDestinationLocation;
    return LatLng(location['latitude'], location['longitude']);
  }

  Widget _buildPanelContent(List<MyUser> carPoolerList) {
    final googleMapProvider = Provider.of<GoogleMapServiceProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // If friend list is not empty
          _isCarPoolListEmpty!
              ? _buildEmptyFriendListMessage()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FriendList(friendNameList: carPoolerList),
                    IconButton(
                      iconSize: 25,
                      onPressed: () {
                        context.pushNamed("addcarpooler");
                      },
                      icon: const Icon(Icons.navigate_next),
                    )
                  ],
                ),

          RidePaymentCard(
            price: price!,
          ),
          const SizedBox(height: 15),
          GreenButton(
            onPressed: () async {
              final LatLng userLocation =
                  getLatLngFromProvider(context, 'pickup');

              // Show a loading popup indicating that the app is finding a driver
              showFindingDriverDialog(context);

              // Delay execution for 3 seconds
              await Future.delayed(const Duration(seconds: 3));

              // Dismiss the finding driver dialog
              Navigator.of(context).pop();

              // Show a popup indicating that the driver has been found
              showFoundDriverDialog(context);

              // Delay execution for 2 seconds
              await Future.delayed(const Duration(seconds: 2));

              // Dismiss the found driver dialog
              Navigator.of(context).pop();

              // Add the driver marker on the map
              LatLng nearestDriverlatLng =
                  findNearestDriver(userLocation, mockDrivers!);
              Marker driverMarker = Marker(
                markerId: const MarkerId('driverLocation'),
                icon: BitmapDescriptor.defaultMarker,
                position: nearestDriverlatLng,
              );
              markers.add(driverMarker);

              // Fetch polyline points from the driver to the user's destination
              await googleMapProvider.fetchPolylinePoints(
                  nearestDriverlatLng, userLocation, false);

              // Generate and draw the polyline from the driver to the user's destination
              final coordinateFromDriverToUser =
                  googleMapProvider.coordinatesFromDriverToUser;
              generatePolyLineFromPoints(coordinateFromDriverToUser!);
              // Show a popup indicating that the driver has arrived at the user's destination

              // Move the driver marker along the polyline
              moveDriverMarkerAlongPolyline(
                  driverMarker, coordinateFromDriverToUser, false);

              await Future.delayed(const Duration(seconds: 5));
              // Draw the polyline from the user to the destination
              final coordinateFromUserToDestination =
                  googleMapProvider.coordinatesFromUserToDestination;
              generatePolyLineFromPoints(coordinateFromUserToDestination!);

              // Move the driver marker along the new polyline
              moveDriverMarkerAlongPolyline(
                  driverMarker, coordinateFromUserToDestination, true);
              await Future.delayed(const Duration(seconds: 5));

              if (mounted) {
                //work around for pushAndPopUntil
                while ((context.canPop()) &&
                    (ModalRoute.of(context)!.settings.name != "home")) {
                  context.pop();
                }
                final rideProvider =
                    Provider.of<RideProvider>(context, listen: false);

                rideProvider.createRide();
                rideProvider.clearData();
                _isCarPoolListEmpty = true;
                print('Now the list is${rideProvider.sharedWithFriends}');
                context.pushNamed("feedback");
              }
            },
            text: 'Order now',
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildEmptyFriendListMessage() {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Oh no! You're alone...",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                "Discounts await for you",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          IconButton(
            splashColor: tertiaryColor,
            iconSize: 25,
            onPressed: () {
              context.pushNamed("addcarpooler");
            },
            icon: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleMap(LatLng pickUpLatLng, LatLng destinationLatLng) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: pickUpLatLng,
        zoom: 10,
      ),
      markers: Set<Marker>.of(markers),
      polylines: Set<Polyline>.of(polylines.values),
    );
  }
}
