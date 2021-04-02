import 'package:flightfinder/models/flight.dart';

abstract class Api {
  Future<Flight> getFlights(limit, offset);
}
