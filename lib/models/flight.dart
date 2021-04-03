class Flight {
  final String name; // Name of Airline
  final String number; // Flight Number
  final String
      depAirport; // Departure Airport Name (ie, 'San Francisco International')
  final String depAirportIata; // Departure Airport IATA code (ie, 'DFW')
  final String
      arrAirport; // Arrival Airport Name (ie, 'Dallas/Fort Worth International')
  final String arrAirportIata; // Departure Airport IATA code (ie, 'SFO')
  final DateTime depTime; // Flight Departure Time
  final DateTime arrTime; // Flight Arrival Time
  final String icao; // Airline company code

  Flight({
    this.name,
    this.number,
    this.depAirport,
    this.depAirportIata,
    this.arrAirport,
    this.arrAirportIata,
    this.depTime,
    this.arrTime,
    this.icao,
  });

  factory Flight.fromMap(Map<dynamic, dynamic> data) {
    if (data == null) {
      return null;
    }
    print(data);
    return Flight(
      name: data['airline']['name'],
      number: data['flight']['number'],
      depAirport: data['departure']['airport'],
      depAirportIata: data['departure']['iata'],
      arrAirport: data['arrival']['airport'],
      arrAirportIata: data['arrival']['iata'],
      depTime: DateTime.parse(data['departure']['scheduled']),
      arrTime: DateTime.parse(data['arrival']['scheduled']),
      icao: data['airline']['icao'],
    );
  }
}
