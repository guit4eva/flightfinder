import 'package:flightfinder/models/airport.dart';
import 'package:flightfinder/models/flight.dart';

abstract class Api {
  Future<List<Airport>> getAirports();
  Future<List<Flight>> getFlights({int docLimit, int offset});
}
