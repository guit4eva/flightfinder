import 'dart:convert';

// =============================================================================
// Use in Production Mode
// =============================================================================
import 'package:flightfinder/models/airport.dart';
import 'package:flightfinder/models/flight.dart';
import 'package:flightfinder/services/api.dart';
import 'package:flutter/services.dart';

class HttpApi implements Api {
  Future<List<Airport>> getAirports() {}
  Future<List<Flight>> getFlights({int docLimit, int offset}) async {
    var _json =
        await rootBundle.loadString('assets/json/dummy_flight_data.json');
    Map<String, dynamic> _flights = jsonDecode(_json);
    return await _flights['data'];
  }
}
