import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';

enum GPSErrorType {
  noSignal,
  denied,
  unable,
}

Map<GPSErrorType, GPSError> gpsError = {
  GPSErrorType.noSignal: const GPSError(
    title: 'Erreur',
    message:
        "Nous ne sommes pas parvenu à déterminer votre localisation actuelle.",
  ),
  GPSErrorType.denied: const GPSError(
    title: 'Service GPS refusé.',
    message:
        "Autorisez la géolocalisation pour voir les endroits proches de vous.",
    action: kIsWeb ? null : _openSettings,
  ),
  GPSErrorType.unable: const GPSError(
    title: 'Service GPS non disponible.',
    message: "Votre apapreil n'est pas en mesure de détecter votre position.",
  ),
};

void _openSettings() {
  AppSettings.openAppSettings();
}

class GPSError implements Exception {
  const GPSError({required this.title, required this.message, this.action});

  final String title;
  final String message;
  final VoidCallback? action;

  @override
  String toString() {
    return 'title: $title, message: $message';
  }
}
