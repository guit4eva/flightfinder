import 'package:flightfinder/models/airport.dart';
import 'package:flutter/cupertino.dart';

class Flight extends ChangeNotifier {
  final String name; // Name of Airline
  final String number; // Flight Number
  Airport
      depAirport; // Departure Airport Name (ie, 'San Francisco International')
  Airport
      arrAirport; // Arrival Airport Name (ie, 'Dallas/Fort Worth International')
  final DateTime depTime; // Flight Departure Time
  final DateTime arrTime; // Flight Arrival Time
  final String icao; // Airline company code

  Flight({
    this.name,
    this.number,
    this.depAirport,
    this.arrAirport,
    this.depTime,
    this.arrTime,
    this.icao,
  });

  factory Flight.fromMap(Map<dynamic, dynamic> data) {
    if (data == null) {
      return null;
    }
    return Flight(
      name: data['airline']['name'],
      number: data['flight']['number'],
      depAirport:
          data['departure'] != null ? Airport.fromMap(data['departure']) : null,
      arrAirport:
          data['arrival'] != null ? Airport.fromMap(data['arrival']) : null,
      depTime: data['departure']['scheduled'] != null
          ? DateTime.parse(data['departure']['scheduled'])
          : null,
      arrTime: data['arrival']['scheduled'] != null
          ? DateTime.parse(data['arrival']['scheduled'])
          : null,
      icao: data['airline']['icao'],
    );
  }
  void updateDepartureAirport(Airport airport) {
    depAirport = airport;
    arrAirport = null; // Reset arrival airport
    notifyListeners();
  }

  void updateArrivalAirport(Airport airport) {
    arrAirport = airport;
    notifyListeners();
  }

  void resetSelectedAirports() {
    depAirport = null;
    arrAirport = null;
  }
}
