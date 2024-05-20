import 'dart:math';

import 'package:everide_frontend/src/provider/order_provider.dart';
import 'package:everide_frontend/src/provider/user_provider.dart';
import 'package:everide_frontend/src/widgets/buttons/pick_me_up_button.dart';
import 'package:everide_frontend/src/widgets/friend_list.dart';
import 'package:everide_frontend/src/widgets/ride_payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../constants/api_path.dart';
import '../constants/colors.dart';
import '../models/my_user_model.dart';
import '../provider/google_map_service_provider.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

LatLng stringToLatLng(String latStr, String lngStr) {
  double latitude = double.parse(latStr);
  double longitude = double.parse(latStr);
  return LatLng(latitude, longitude);
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

double getDistance(List<LatLng> coordinates) {
  double totalDistance = 0;
  for (int i = 0; i < coordinates.length - 1; i++) {
    totalDistance += calculateDistance(
        coordinates[i].latitude,
        coordinates[i].longitude,
        coordinates[i + 1].latitude,
        coordinates[i + 1].longitude);
  }
  return totalDistance;
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  bool? _isFriendListEmpty;
  List<LatLng>? coordinates; //to calculate the distance
  Map<PolylineId, Polyline> polylines = {}; // Store the polylines
  // late final totalDistance;
  double? _totalDistance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeMap();
    });
  }

  Future<List<LatLng>> fetchPolylinePoints(
      LatLng pickUpLocation, LatLng destinationLocation) async {
    final polylinePoints = PolylinePoints();

    // This will get routes between the pickup and destination locations
    final result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapApi,
        PointLatLng(pickUpLocation.latitude, pickUpLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude),
        travelMode: TravelMode.driving);

    if (result.points.isNotEmpty) {
      // Map the PolylinePoints into LatLng
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      debugPrint(result.errorMessage);
      return [];
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

  Future<void> initializeMap() async {
    final LatLng pickUpLatLng = getLatLngFromProvider(context, 'pickup');
    final LatLng destinationLatLng =
        getLatLngFromProvider(context, 'destination');
    coordinates = await fetchPolylinePoints(pickUpLatLng,
        destinationLatLng); // Get the polyline between the source and destination locations
    generatePolyLineFromPoints(coordinates!); // Draw the polyline
    setState(() {
      _totalDistance = getDistance(coordinates!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> friendNameList = getFriendNames(context);
    _isFriendListEmpty = friendNameList.isEmpty;

    final LatLng pickUpLatLng = getLatLngFromProvider(context, 'pickup');
    final LatLng destinationLatLng =
        getLatLngFromProvider(context, 'destination');

    return Scaffold(
      body: SlidingUpPanel(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        minHeight: MediaQuery.of(context).size.height * 0.4,
        maxHeight: MediaQuery.of(context).size.height * 0.5,
        panel: _buildPanelContent(friendNameList),
        body: _buildGoogleMap(pickUpLatLng, destinationLatLng),
      ),
    );
  }

  List<String> getFriendNames(BuildContext context) {
    final List<MyUser> carPoolerList =
        Provider.of<OrderProvider>(context).carpooler;
    return carPoolerList.map((e) => e.username).toList();
  }

  LatLng getLatLngFromProvider(BuildContext context, String type) {
    final provider =
        Provider.of<GoogleMapServiceProvider>(context, listen: false);
    final Map<String, dynamic> location = type == 'pickup'
        ? provider.selectedPickUpLocation
        : provider.selectedDestinationLocation;
    return LatLng(location['latitude'], location['longitude']);
  }

  Widget _buildPanelContent(List<String> friendNameList) {
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
          _isFriendListEmpty!
              ? _buildEmptyFriendListMessage()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FriendList(friendNameList: friendNameList),
                    IconButton(
                      iconSize: 25,
                      onPressed: () {
                        context.pushNamed("addcarpooler");
                      },
                      icon: const Icon(Icons.navigate_next),
                    )
                  ],
                ),

          const RidePaymentCard(),
          const SizedBox(height: 15),
          GreenButton(onPressed: () {}, text: 'Order now'),
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
      markers: {
        Marker(
          markerId: const MarkerId('currentLocation'),
          icon: BitmapDescriptor.defaultMarker,
          position: pickUpLatLng,
        ),
        Marker(
          markerId: const MarkerId('destinationLocation'),
          icon: BitmapDescriptor.defaultMarker,
          position: destinationLatLng,
        ),
      },
      polylines: Set<Polyline>.of(polylines.values),
    );
  }
}
