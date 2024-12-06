import 'package:fedhubs_pro/models/gps_error.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as l;


class GeolocatorService {
  static Future<Position> determinePosition() async {
    LocationPermission permission;
    bool _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await Geolocator.openLocationSettings();
      if (!_serviceEnabled) {
        throw Future.error(gpsError[GPSErrorType.unable] as GPSError);
      }
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        return Future.error(gpsError[GPSErrorType.denied] as GPSError);
      }
    }

    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } on LocationServiceDisabledException {
      return Future.error(gpsError[GPSErrorType.unable] as GPSError);
    }
  }

  static Future<bool> checkPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}

class LocationService {
  static Future<l.LocationData> determinePosition() async {
    l.Location location = l.Location();

    bool _serviceEnabled;
    l.PermissionStatus _permissionGranted;
    l.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw gpsError[GPSErrorType.unable] as GPSError;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == l.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != l.PermissionStatus.granted) {
        throw gpsError[GPSErrorType.denied] as GPSError;
      }
    } else if (_permissionGranted == l.PermissionStatus.deniedForever) {
      throw gpsError[GPSErrorType.denied] as GPSError;
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  static Future<bool> checkPermission() async {
    final permission = await l.Location().hasPermission();
    return permission == l.PermissionStatus.granted ||
        permission == l.PermissionStatus.grantedLimited;
  }
}
