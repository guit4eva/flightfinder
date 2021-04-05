// =============================================================================
// Display Flight Information in List View
// =============================================================================
import 'package:flightfinder/models/flight.dart';
import 'package:flightfinder/screens/view_flight_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class FlightCard extends StatelessWidget {
  const FlightCard({
    Key key,
    this.flight,
  }) : super(key: key);

  final Flight flight;

  @override
  Widget build(BuildContext context) {
    DateTime _depDate = flight?.depTime;
    DateTime _arrDate = flight?.arrTime;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
              // leading: Container(
              //   width: 50,
              //   child: Column(
              //     children: [
              //       // if (flight.icao != null && flight.icao.isNotEmpty)
              //       //   Expanded(
              //       //     child: Image.asset(
              //       //       'assets/img/airlines/${flight.icao.toLowerCase()}.png',
              //       //       errorBuilder: (BuildContext context, Object exception,
              //       //           StackTrace stackTrace) {
              //       //         return Icon(
              //       //           Icons.flight,
              //       //         );
              //       //       },
              //       //       fit: BoxFit.contain,
              //       //     ),
              //       //   ),
              //       Expanded(
              //         child: Icon(Icons.flight),
              //       ),
              //       SizedBox(
              //         height: 14.0,
              //       ),
              //       Expanded(
              //         child: Text(flight.number),
              //       )
              //     ],
              //   ),
              // ),
              title: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(flight.depAirport.iataCode),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Colors.grey,
                    ),
                  ),
                  Text(flight.arrAirport.iataCode),
                ],
              ),
              trailing: Column(
                children: [
                  Text(
                    "${DateFormat.yMMMd().format(_depDate)}",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text("DEP: ${DateFormat.Hm().format(_depDate)}"),
                  Text("ARR: ${DateFormat.Hm().format(_arrDate)}"),
                ],
              ),
              subtitle: Text('${flight.name} (${flight.number})'),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: ViewFlightScreen(
                      flight: flight,
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
