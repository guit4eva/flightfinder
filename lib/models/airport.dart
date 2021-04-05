import 'package:google_maps_flutter/google_maps_flutter.dart';

class Airport {
  final String name;
  final String iataCode;
  final LatLng latLng;

  Airport({
    this.name,
    this.iataCode,
    this.latLng,
  });

  factory Airport.fromMap(data) {
    if (data == null) {
      return null;
    }
    return Airport(
      name: data['airport'],
      iataCode: data['iata'],
      latLng: data['latitude'] != null && data['longitude'] != null
          ? LatLng(double.tryParse(data['latitude']),
              double.tryParse(data['longitude']))
          : null,
    );
  }
}
