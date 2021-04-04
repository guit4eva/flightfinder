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
  }) async {
    bool _noMoreDataAvailable = false;
    docLimit = docLimit ?? 1;
    offset = offset ?? 1;
    currentList = currentList ?? [];
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
    List<dynamic> _flights = jsonDecode(_json)['data'];
    if (offset + docLimit > _flights.length) _noMoreDataAvailable = true;
    // -------------------------------------------------------------------------
    // Add flight data to currentList
    // -------------------------------------------------------------------------
    if (_noMoreDataAvailable) {
      for (var i = offset; i < _flights.length - offset; i++) {
        currentList.add(await _flights[i]);
      }
    } else {
      for (var i = offset; i <= offset + docLimit; i++) {
        currentList.add(await _flights[i]);
      }
    }

    callback(currentList, _noMoreDataAvailable);
    return currentList;
  }
}
