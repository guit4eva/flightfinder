import 'dart:convert';

// =============================================================================
// Use in Production Mode
// =============================================================================
import 'package:dio/dio.dart';
import 'package:flightfinder/models/airport.dart';
import 'package:flightfinder/models/flight.dart';
import 'package:flightfinder/services/api.dart';
import 'package:flutter/services.dart';

class HttpApi implements Api {
  Future<List<Airport>> getAirports() async {
    print("USING REAL API");

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
    final String _apiKey =
        '7edeaf4a7696a7302e078656755e1644'; //TODO: Load API key securely

    final String _flightsBaseUri =
        'http://api.aviationstack.com/v1/flights?access_key=$_apiKey';

    String _uri = _flightsBaseUri + '&limit=$docLimit&offset=$offset';
    // add departure location
    _uri = _uri + '&dep_iata=${departureAirport.iataCode}';

    // add arrival location
    _uri = _uri + '&arr_iata=${arrivalAirport.iataCode}';

    final response = await Dio().get(_uri);
    // ---------------------------------------------------------------------------
    // Decode JSON
    // ---------------------------------------------------------------------------
    var _flightData = response.data['data'];

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
    // TODO: Sorting needs work here - results are not loaded chronologically with the infinite scroll
    currentList.sort((a, b) => a.depTime.compareTo(b.depTime));
    callback(currentList, docsToFetch < docLimit);
    return currentList;
  }
}
