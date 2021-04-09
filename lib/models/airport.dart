import 'package:google_maps_flutter/google_maps_flutter.dart';

class Airport {
  final String? name;
  final String iataCode;
  final LatLng? latLng;

  Airport({
    this.name,
    required this.iataCode,
    this.latLng,
  });

  factory Airport.fromMap(data) {
    if (data == null) {
      throw "Something went wrong (airport.dart)";
    }
    return Airport(
      name: data['airport'],
      iataCode: data['iata'],
      latLng: data['latitude'] != null
          ? LatLng(
              double.parse(data['latitude']), double.parse(data['longitude']))
          : null,
    );
  }
}
