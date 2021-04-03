import 'dart:convert';

// =============================================================================
// Use in Production Mode
// =============================================================================
import 'package:flightfinder/services/api.dart';
import 'package:flutter/services.dart';

class HtppApi implements Api {
  Future<List<dynamic>> getFlights({docLimit, offset}) async {
    var _json =
        await rootBundle.loadString('assets/json/dummy_flight_data.json');
    Map<String, dynamic> _flights = jsonDecode(_json);
    return await _flights['data'];
  }
}
