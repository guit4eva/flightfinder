import 'package:flightfinder/models/airport.dart';
import 'package:flightfinder/models/flight.dart';

abstract class Api {
  Future<List<Airport>> getAirports();
  Future<List<Flight>> getFlights({
    List<Flight> currentList,
    int docLimit,
    int offset,
    Function callback,
    Airport departureAirport,
    Airport arrivalAirport,
  });
}
