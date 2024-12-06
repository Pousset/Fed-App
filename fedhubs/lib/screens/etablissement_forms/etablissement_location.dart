import 'dart:math';
import 'package:fedhubs_pro/models/coordinates.dart';
import 'package:fedhubs_pro/models/gps_error.dart';
import 'package:fedhubs_pro/screens/etablissement_forms/etablissement_logo_et_couverture.dart';
import 'package:fedhubs_pro/services/local/local_database.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

enum LocationPageAccessMode {
  first,
  update,
}

class LocationPage extends StatefulWidget {
 const LocationPage({Key? key, required this.mode}) : super(key: key);
 final LocationPageAccessMode mode;

  static Future<void> push(BuildContext context, LocationPageAccessMode mode) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => LocationPage(mode: mode),
      fullscreenDialog: true,
    ));
  } 

  @override
  State<LocationPage> createState() => _LocationPageState();
  }

class _LocationPageState extends State<LocationPage> {
  TextEditingController _locationController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();

  final mapController = MapController();
  final database = LocalDatabase();
  late final CoordinatesModel coordinates ;
  

 GPSError? locationErrorMessage;
  bool isLoading = false;
  bool locationLoading = false;
  bool hideMap = false;
  bool isUpdated = false;
  late int step;

 void _submit() async {
    _textFocusNode.unfocus();
    try {
      List<Location> locations =
          await locationFromAddress(_locationController.text);
      if (locations.isNotEmpty) {
        coordinates.lat = locations.first.latitude;
        coordinates.lon = locations.first.longitude;
      }
    } catch (_) {}
    step = 2;
    isUpdated = true;
    hideMap = false;
    setState(() {});
  }

 @override
  void initState() {
    step = widget.mode == LocationPageAccessMode.first ? 0 : 2;
    if (step == 0) {
      coordinates = CoordinatesModel();
    } else {
      final coo = database.getCurrentCoordinates();
      coordinates = CoordinatesModel(lat: coo?.lat ?? 0, lon: coo?.lon ?? 0);
    }
    locationErrorMessage = null;

    _locationController = TextEditingController(text: database.getCurrentAddress());
    super.initState();
  }


  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
  
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0.6),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._buildHeader(context, screenSize),
                    const SizedBox(height: 20),
                  
                  TextFormField( 
                      controller: _locationController,
                      onTap: () => setState(() {}),
                      style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                  labelText: 'Adresse de l’établissement',
                                  labelStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                  ),
                                  fillColor: Colors.white,
                                  prefixIconConstraints: const BoxConstraints(minWidth: 56),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                filled: true,
                                )
                                ),

                    const SizedBox(height: 20),
                    _buildMap(context, screenSize),
                    const Expanded(flex: 1, child: SizedBox()),
                    CustomFlatButton(
                      width: screenSize.width - 48,
                      text: 'Suivant',
                      color: Theme.of(context).secondaryHeaderColor,
                      onPressed: () => LogoANDCouverturePage.push(context)
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMap(BuildContext context, Size screenSize) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        border: Border.all(
          color: Theme.of(context).secondaryHeaderColor,
          width: 2,
        ),
      ),
      width: screenSize.width - 32,
      height: 320,
      child: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          clipBehavior: Clip.hardEdge,
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: LatLng(
                coordinates.lat != null
                    ? coordinates.lat
                    : 48.856614,
                coordinates.lon != null
                    ? coordinates.lon
                    : 2.3522219,
              ),
              zoom: 16,
              interactiveFlags: 0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.fedhubs.fedhubs_pub',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: [
                  if (coordinates.lat != null)
                    Marker(
                      point: LatLng(
                        coordinates.lat != null
                            ? coordinates.lat
                            : 48.856614,
                        coordinates.lon != null
                            ? coordinates.lon
                            : 2.3522219,
                      ),
                      builder: (context) => Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -8,
                            left: -8,
                            child: Icon(
                              Icons.circle,
                              color: Theme.of(context)
                                  .secondaryHeaderColor
                                  .withOpacity(0.5),
                              size: 48,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Icon(
                              Icons.location_on,
                              color: Theme.of(context).primaryColor,
                              size: 32,
                              shadows: [
                                BoxShadow(
                                    blurRadius: 16,
                                    color: Colors.black.withOpacity(0.4)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

Widget _buildLocationTextField(Size screenSize, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 35,
              blurStyle: BlurStyle.outer)
        ],
        borderRadius: BorderRadius.all(Radius.circular(120.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
        child: SizedBox(
          width: screenSize.width - 60,
          child: TextField(
            controller: _locationController,
            focusNode: _textFocusNode,
            onTap: () {
              hideMap = true;
            },
            onChanged: (_) => setState(() {}),
            onSubmitted: (value) =>
                _locationController.text.trim().isNotEmpty ? _submit() : null,
            cursorColor: const Color.fromRGBO(0, 0, 0, 0.6),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 25),
              prefixIconConstraints: const BoxConstraints(minWidth: 56),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(120.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(120.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Stack(children: [
                Icon(
                  Icons.circle,
                  color: Theme.of(context).secondaryHeaderColor,
                  size: 40,
                ),
                const Positioned(
                  left: 8,
                  bottom: 8,
                  child: Icon(
                    Icons.location_on,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ]),
              suffixIcon:
                  hideMap == true && _locationController.text.trim().isNotEmpty
                      ? GestureDetector(
                          onTap: () => _submit(),
                          onLongPress: () {},
                          child: Icon(
                            Icons.navigate_next_rounded,
                            size: 40,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        )
                      : null,
            ),
          ),
        ),
      ),
    );
  }




List<Widget> _buildHeader(BuildContext context, Size screenSize) {
    return [

      SizedBox(height: 25),
      Align(
                    alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        child: Stack(children: [
                        Icon(
                          Icons.circle,
                          color: Theme.of(context).secondaryHeaderColor,
                          size: 40,
                        ),
                        const Positioned(
                          left: 14,
                          bottom: 10,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        ]),
                      onTap: () => Navigator.of(context).pop(),),
                    ),
      SizedBox(height: 25),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Emplacement',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.45),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    ];
  }
  
}
  


