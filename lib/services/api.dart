import 'package:flightfinder/models/airport.dart';
import 'package:flightfinder/models/flight.dart';

abstract class Api {
  Future<List<Airport>> getAirports();
  Future<List<Flight>> getFlights({
    required List<Flight> currentList,
    required int docLimit,
    required int offset,
    required Function callback,
    required Airport departureAirport,
    required Airport arrivalAirport,
  });
}
