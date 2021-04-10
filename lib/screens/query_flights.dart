// =============================================================================
// Query for flights via arrival and departure selects
// =============================================================================
import 'package:flightfinder/components/custom_app_bar.dart';
import 'package:flightfinder/components/custom_elevated_button.dart';
import 'package:flightfinder/components/small_header.dart';
import 'package:flightfinder/models/airport.dart';
import 'package:flightfinder/models/app_mode.dart';
import 'package:flightfinder/models/flight.dart';
import 'package:flightfinder/screens/list_flights_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class QueryFlightsScreen extends StatefulWidget {
  @override
  _QueryFlightsScreenState createState() => _QueryFlightsScreenState();
}

class _QueryFlightsScreenState extends State<QueryFlightsScreen> {
  late Future<List<Airport>> _airportsFuture;
  @override
  void initState() {
    // -------------------------------------------------------------------------
    // Check whether to use Mock or Real API
    // -------------------------------------------------------------------------
    _airportsFuture = context.read(appModeProvider).apiToUse.getAirports();
    // Reset Airports
    // > prevents dropdown duplicate error: https://i.stack.imgur.com/nX0PJ.png
    context.read(selectedFlightProvider).resetSelectedAirports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder<List<Airport>>(
        future: _airportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            Center(
              child: Text("Loading..."),
            );
          if (snapshot.hasData) {
            List<Airport> _depAirports = snapshot.data!;
            List<Airport> _arrAirports = snapshot.data!;
            return Consumer(
              builder: (context, watch, child) {
                final _myFlight = watch(selectedFlightProvider);
                return Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            // -------------------------------------------------
                            // Flying From
                            // -------------------------------------------------
                            Column(
                              children: [
                                SmallHeader(text: "Departing from:"),
                                DropdownContainer(
                                  airports: _depAirports,
                                  selectedValue: _myFlight.depAirport,
                                  callback: (value) => context
                                      .read(selectedFlightProvider)
                                      .updateDepartureAirport(value),
                                ),
                              ],
                            ),
                            // -------------------------------------------------
                            // Flying To
                            // -------------------------------------------------
                            if (_myFlight.depAirport != null)
                              Column(
                                children: [
                                  SmallHeader(text: "Arriving at:"),
                                  DropdownContainer(
                                    airports: _arrAirports,
                                    selectedValue: _myFlight.arrAirport,
                                    callback: (value) => context
                                        .read(selectedFlightProvider)
                                        .updateArrivalAirport(value),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            if (_myFlight.arrAirport != null)
                              Container(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    CustomElevatedButton(
                                      label: "Show Flights",
                                      bgColor: Theme.of(context)
                                          .secondaryHeaderColor,
                                      onPressed: () => Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: ListFlightsScreen(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: Text("Nothing to show..."));
        },
      ),
    );
  }
}

// TODO: Remove departure flight from arrival flight options
class DropdownContainer extends StatelessWidget {
  final List<Airport> airports;
  final Function callback;
  final Airport? selectedValue;

  const DropdownContainer({
    Key? key,
    required this.airports,
    required this.callback,
    this.selectedValue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          child: Container(
            color: Colors.white,
            child: DropdownButton<Airport>(
              items: airports
                  .map(
                    (airport) => DropdownMenuItem<Airport>(
                      value: airport,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(airport.name! + ' (${airport.iataCode})'),
                      ),
                    ),
                  )
                  .toList(),
              hint: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Select airport"),
              ),
              value: selectedValue,
              underline: Offstage(),
              onChanged: callback as void Function(Airport?)?,
            ),
          ),
        ),
      ],
    );
  }
}
