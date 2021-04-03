// =============================================================================
// Use in Test Mode
// =============================================================================
import 'dart:convert';
import 'package:flightfinder/services/api.dart';
import 'package:flutter/services.dart';

class MockApi implements Api {
  Future<List<dynamic>> getFlights({docLimit, offset}) async {
    print('Mock data is currently being used');
    var _json =
        await rootBundle.loadString('assets/json/dummy_flight_data.json');
    Map<String, dynamic> _flights = jsonDecode(_json);
    return await _flights['data'];
  }
}
