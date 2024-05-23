// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController _mapController;
//   String _apiKey = "YOUR_GOOGLE_MAPS_API_KEY";

//   @override
//   void initState() {
//     super.initState();
//     _setInitialLocation();
//   }

//   Future<void> _setInitialLocation() async {
//     // This is a placeholder for setting initial location, ideally you'd get user's current location.
//     LatLng initialLocation = LatLng(37.7749, -122.4194); // San Francisco coordinates for example

//     Provider.of<LocationProvider>(context, listen: false).currentLocation = initialLocation;
//     Provider.of<LocationProvider>(context, listen: false).fetchNearbyPlaces(_apiKey);
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Nearby Pick-Up Locations'),
//       ),
//       body: Stack(
//         children: [
//           Consumer<LocationProvider>(
//             builder: (context, locationProvider, child) {
//               return GoogleMap(
//                 onMapCreated: _onMapCreated,
//                 initialCameraPosition: CameraPosition(
//                   target: locationProvider.currentLocation,
//                   zoom: 14,
//                 ),
//                 markers: locationProvider.placePredictions.map((prediction) {
//                   // Create a marker for each prediction
//                   return Marker(
//                     markerId: MarkerId(prediction.placeId),
//                     position: LatLng(
//                       locationProvider.currentLocation.latitude,
//                       locationProvider.currentLocation.longitude,
//                     ), // Update this to the correct position if you have lat/lng
//                     infoWindow: InfoWindow(title: prediction.description),
//                   );
//                 }).toSet(),
//               );
//             },
//           ),
//           Consumer<LocationProvider>(
//             builder: (context, locationProvider, child) {
//               return locationProvider.isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : Align(
//                       alignment: Alignment.bottomLeft,
//                       child: Container(
//                         height: 200,
//                         child: ListView.builder(
//                           itemCount: locationProvider.placePredictions.length,
//                           itemBuilder: (context, index) {
//                             return GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => NextPage(
//                                       destination: locationProvider.placePredictions[index].description!,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: ListTile(
//                                 leading: const Icon(Icons.location_on),
//                                 title: Text(locationProvider.placePredictions[index].description!),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class NextPage extends StatelessWidget {
//   final String destination;

//   NextPage({required this.destination});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Next Page'),
//       ),
//       body: Center(
//         child: Text('Selected destination: $destination'),
//       ),
//     );
//   }
// }


  // Parse the JSON
//   final Map<String, dynamic> data = json.decode(jsonString);

//   // Extract the list of results
//   final List<dynamic> results = data['results'];

//   // Create a list of maps with name, latitude, and longitude
  // final List<Map<String, dynamic>> locations = results.map((result) {
  //   final name = result['name'];
  //   final lat = result['geometry']['location']['lat'];
  //   final lng = result['geometry']['location']['lng'];
  //   return {
  //     'name': name,
  //     'latitude': lat,
  //     'longitude': lng,
  //   };
  // }).toList();

//   // Print the locations
//   locations.forEach((location) {
//     print('Name: ${location['name']}, Latitude: ${location['latitude']}, Longitude: ${location['longitude']}');
//   });
// }