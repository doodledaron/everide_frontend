import 'package:everide_frontend/src/constants/app_contants.dart';
import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/provider/google_map_service_provider.dart';
import 'package:everide_frontend/src/utils/services/google_map_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../widgets/custom_loading_indicator.dart';

class ChooseDestinationScreen extends StatefulWidget {
  const ChooseDestinationScreen({super.key, required this.pickUpLatLng});
  final LatLng pickUpLatLng;

  @override
  State<ChooseDestinationScreen> createState() =>
      _ChooseDestinationScreenState();
}

class _ChooseDestinationScreenState extends State<ChooseDestinationScreen> {
  final TextEditingController _pickUpLocationController =
      TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  var uuid = const Uuid(); //for session token
  String _sessionToken = '1234567890';
 
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _destinationController.addListener(() {
      _onChanged();
    });
    _getPickUpLocation();
  }

  _onChanged() async {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    _getAutoCompletePlaceNames(_destinationController.text);
  }

//didChangeDependencies is called automatically when an inherited widget that your widget depends on changes.
//Unlike the build method, which is called whenever the widget needs to be rendered, didChangeDependencies is called only when the dependencies change. This can make it a more efficient place to perform operations that only need to happen when dependencies change.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Listen to changes in the provider to update the text controller
    final provider = Provider.of<GoogleMapServiceProvider>(context);
    _pickUpLocationController.text = provider.pickUpLocation;
  }

  void _getPickUpLocation() {
    try {
      //provider fetch the pickup location
      Provider.of<GoogleMapServiceProvider>(context, listen: false)
          .fetchPickUpLocation(widget.pickUpLatLng);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void _getAutoCompletePlaceNames(String input) async {
    // Generate or obtain your session token
    try {
      Provider.of<GoogleMapServiceProvider>(context, listen: false)
          .fetchPlaceNameAutocomplete(input, _sessionToken);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void _onPlaceTapped(String placeName, Map<String, dynamic> location) async {
    // Update the text field immediately
    setState(() {
      _destinationController.text = placeName;
      _isLoading = true;
    });

    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    setTheDestinationLocation(location);
    // Navigate to the next page
    setState(() {
      _isLoading = false;
    });
  }

  void setTheDestinationLocation(Map<String, dynamic> destination) {
    Provider.of<GoogleMapServiceProvider>(context, listen: false)
        .saveSelectedDestinationLocation(destination);

    final location =
        Provider.of<GoogleMapServiceProvider>(context, listen: false)
            .selectedDestinationLocation;
    print(location);
  }

  @override
  Widget build(BuildContext context) {
    //change latLng pickup to String

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: const Text('Choose your destination'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: _isLoading
            ? const Center(
                child: CustomLoadingIndicator(),
              )
            : Column(
                children: [
                  //pick up location
                  TextField(
                    controller: _pickUpLocationController,
                    readOnly: true, //user cannot change this
                    decoration: InputDecoration(
                      filled: true,
                      label: const Text(
                        'Pick-up location',
                        style: TextStyle(color: Colors.black),
                      ),
                      fillColor: secondaryColor,
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(kBorderRadiusSearchBar),
                        borderSide: const BorderSide(color: secondaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(kBorderRadiusSearchBar),
                        borderSide: const BorderSide(color: secondaryColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(kBorderRadiusSearchBar),
                        borderSide: const BorderSide(color: secondaryColor),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //destination location
                  TextField(
                    controller: _destinationController,
                    decoration: InputDecoration(
                      filled: true,
                      label: const Text(
                        'Destination',
                        style: TextStyle(color: Colors.black),
                      ),
                      fillColor: secondaryColor,
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(kBorderRadiusSearchBar),
                        borderSide: const BorderSide(color: secondaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(kBorderRadiusSearchBar),
                        borderSide: const BorderSide(color: secondaryColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(kBorderRadiusSearchBar),
                        borderSide: const BorderSide(color: secondaryColor),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusCards)),
                      child: Consumer<GoogleMapServiceProvider>(
                          builder: (context, provider, child) {
                        return ListView.builder(
                            itemCount: provider.placesForAutocomplete.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _onPlaceTapped(
                                      provider.placesForAutocomplete[index]
                                          ['name'],
                                      provider.placesForAutocomplete[index]);
                                  context.pushNamed("choosepickup");
                                },
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.location_on,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    provider.placesForAutocomplete[index]
                                        ['name'],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              );
                            });
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
      ),
    );
  }
}
