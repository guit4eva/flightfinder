// =============================================================================
// Use in Test Mode
// =============================================================================
import 'dart:convert';
import 'package:flightfinder/misc/nice_print.dart';
import 'package:flightfinder/models/airport.dart';
import 'package:flightfinder/models/flight.dart';
import 'package:flightfinder/services/api.dart';
import 'package:flutter/services.dart';

class MockApi implements Api {
  // ---------------------------------------------------------------------------
  // Get Airports
  // ---------------------------------------------------------------------------
  Future<List<Airport>> getAirports() async {
    print("USING MOCK API");
    var _json = await rootBundle.loadString('assets/json/airports.json');
    List<dynamic> _airportData = jsonDecode(_json);
    List<Airport> _airportList = [];
    if (_airportData != null) {
      _airportData.forEach((e) {
        _airportList.add(Airport.fromMap(e));
      });
    }
    return _airportList;
  }

  // ---------------------------------------------------------------------------
  // Query Flights
  // ---------------------------------------------------------------------------
  Future<List<Flight>> getFlights({
    List<Flight> currentList,
    int docLimit,
    int offset,
    Function callback,
    Airport departureAirport,
    Airport arrivalAirport,
  }) async {
    docLimit = docLimit ?? 1;
    offset = offset ?? 1;
    currentList = currentList ?? [];
    int docsToFetch;
    List<Flight> _flights;
    // -------------------------------------------------------------------------
    // Debug information
    // -------------------------------------------------------------------------
    Misc().easyDebug({
      'Data currently used': 'Mock Data',
      'currentList length': currentList.length,
      'docLimit': docLimit,
      'offset': offset,
      'departureAirport': departureAirport?.iataCode,
      'arrivalAirport': arrivalAirport?.iataCode,
    });
    // -------------------------------------------------------------------------
    // Load local JSON
    // -------------------------------------------------------------------------
    var _json =
        await rootBundle.loadString('assets/json/dummy_flight_data.json');
    // ---------------------------------------------------------------------------
    // Decode JSON
    // ---------------------------------------------------------------------------
    List<dynamic> _flightData = jsonDecode(_json)['data'];

    docsToFetch = offset + docLimit > _flightData.length
        ? _flights.length - offset
        : offset + docLimit;

    // -------------------------------------------------------------------------
    // Add flight data to currentList
    // -------------------------------------------------------------------------
    for (var i = offset; i < docsToFetch; i++) {
      Flight _flight = Flight.fromMap(_flightData[i]);
      if (_flight.depAirport.iataCode == departureAirport.iataCode &&
          _flight.arrAirport.iataCode == arrivalAirport.iataCode)
        currentList.add(_flight);
    }

    currentList.sort((a, b) => a.depTime.compareTo(b.depTime));
    callback(currentList, docsToFetch < docLimit);
    return currentList;
  }
}
