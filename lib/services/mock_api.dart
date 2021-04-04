// =============================================================================
// Use in Test Mode
// =============================================================================
import 'dart:convert';
import 'package:flightfinder/misc/nice_print.dart';
import 'package:flightfinder/services/api.dart';
import 'package:flutter/services.dart';

class MockApi implements Api {
  Future<List<dynamic>> getFlights({
    List<dynamic> currentList,
    int docLimit,
    int offset,
    Function callback,
    String departureAirport,
    String arrivalAirport,
  }) async {
    docLimit = docLimit ?? 1;
    offset = offset ?? 1;
    currentList = currentList ?? [];
    int docsToFetch;
    // -------------------------------------------------------------------------
    // Debug information
    // -------------------------------------------------------------------------
    Misc().easyDebug({
      'Data currently used': 'Mock Data',
      'currentList length': currentList.length,
      'docLimit': docLimit,
      'offset': offset
    });
    // -------------------------------------------------------------------------
    // Load local JSON
    // -------------------------------------------------------------------------
    var _json =
        await rootBundle.loadString('assets/json/dummy_flight_data.json');
    // ---------------------------------------------------------------------------
    // Decode JSON
    // ---------------------------------------------------------------------------
    List<dynamic> _flights = await jsonDecode(_json)['data'];
    docsToFetch = offset + docLimit > _flights.length
        ? _flights.length - offset
        : offset + docLimit;

    // -------------------------------------------------------------------------
    // Add flight data to currentList
    // -------------------------------------------------------------------------
    for (var i = offset; i < docsToFetch; i++) {
      currentList.add(_flights[i]);
    }

    callback(currentList, docsToFetch < docLimit);
    return currentList;
  }
}
