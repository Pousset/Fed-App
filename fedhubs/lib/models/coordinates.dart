import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

CoordinatesModel coordinatesModelFromJson(String str) =>
    CoordinatesModel.fromJson(json.decode(str));

String coordinatesModelToJson(CoordinatesModel data) =>
    json.encode(data.toJson());

class CoordinatesModel {
  double lat;
  double lon;

  CoordinatesModel({this.lat = 0, this.lon = 0});

  factory CoordinatesModel.fromJson(Map<String, dynamic> item) {
    return CoordinatesModel(
      lat: item['lat'],
      lon: item['lon'],
    );
  }

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };

  Future fromLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        lat = round(locations.first.latitude, decimals: 8);
        lon = round(locations.first.longitude, decimals: 8);
      }
    } on PlatformException catch (e) {
      if (kDebugMode) print(e);
    }
  }

  @override
  String toString() {
    return 'lat: $lat, lon: $lon';
  }
}
