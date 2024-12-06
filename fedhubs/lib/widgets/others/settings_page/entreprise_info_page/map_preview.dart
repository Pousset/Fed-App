import 'package:fedhubs_pro/models/coordinates.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPreview extends StatefulWidget {
  const MapPreview(
      {super.key, required this.controller, required this.coordinates});

  final MapController controller;
  final CoordinatesModel coordinates;

  @override
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);

    if (widget.coordinates.lat != 0) {
      return SizedBox(
        width: screenSize.width - 32,
        height: 232,
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            clipBehavior: Clip.hardEdge,
            child: FlutterMap(
              mapController: widget.controller,
              options: MapOptions(
                center: LatLng(widget.coordinates.lat, widget.coordinates.lon),
                zoom: 15,
                interactiveFlags: 0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.fedhubs.fedhubs_pro',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: [
                    if (widget.coordinates.lat != 0)
                      Marker(
                        point: LatLng(
                            widget.coordinates.lat, widget.coordinates.lon),
                        builder: (context) => Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: -8,
                              left: -8,
                              child: Icon(
                                Icons.circle,
                                color: Theme.of(context).secondaryHeaderColor,
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
                                      color: Colors.black.withOpacity(0.2)),
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
    } else {
      return const SizedBox();
    }
  }
}
