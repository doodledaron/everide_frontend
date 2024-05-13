import 'dart:async';

import 'package:everide_frontend/src/constants/api_path.dart';
import 'package:everide_frontend/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class PrimaryMapScreenTest extends StatefulWidget {
  const PrimaryMapScreenTest({super.key});

  @override
  State<PrimaryMapScreenTest> createState() => _PrimaryMapScreenTestState();
}

class _PrimaryMapScreenTestState extends State<PrimaryMapScreenTest> {
  final locationController = Location();
  final googlePlex = const LatLng(37.4223, -122.0848);
  final mountainView = const LatLng(37.3861, -122.0848);

  LatLng? currentPosition; // will be used to store the current location of user
  Map<PolylineId, Polyline> polylines = {}; //store the polylines
  late StreamSubscription<LocationData>
      locationSubscription; //so that we could cancel the subscription to currently location when we change the screen
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locationSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await initializeMap());
  }

  Future<void> initializeMap() async {
    await fetchLocationUpdates(); //fetch the current location updates
    final coordinates =
        await fetchPolylinePoints(); //get the polyline between source location and destination location
    print('coordiantes: $coordinates');
    generatePolyLineFromPoints(coordinates); //draw the polyline
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: googlePlex, zoom: 13),
              markers: {
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: currentPosition!,
                ),
                Marker(
                  markerId: const MarkerId('sourceLocation'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: googlePlex,
                ),
                Marker(
                  markerId: const MarkerId('destinationLocation'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: mountainView,
                )
              },
              polylines: Set<Polyline>.of(polylines.values),
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
    locationSubscription = locationController.onLocationChanged.listen((LocationData currentLocation) {
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

  //retrieve the nessasary points (flutter polyline package)
  //the returned a list of position where it will be used to draw the lines
  Future<List<LatLng>> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints();

    //this will get routes btwn googleplex and mountain view
    final result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapApi,
      PointLatLng(googlePlex.latitude, googlePlex.longitude),
      PointLatLng(mountainView.latitude, mountainView.longitude),
    );

    if (result.points.isNotEmpty) {
      //map the PolylinePoints int LatLng
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
        width: 5);

    setState(() => polylines[id] = polyline);
  }
}
