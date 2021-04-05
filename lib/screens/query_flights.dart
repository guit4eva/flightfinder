// =============================================================================
// Query for flights via arrival and departure selects
// =============================================================================
import 'package:flightfinder/components/custom_app_bar.dart';
import 'package:flightfinder/components/custom_elevated_button.dart';
import 'package:flightfinder/components/small_header.dart';
import 'package:flightfinder/misc/globals.dart';
import 'package:flightfinder/misc/nice_print.dart';
import 'package:flightfinder/models/airport.dart';
import 'package:flightfinder/screens/list_flights_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class QueryFlightsScreen extends StatefulWidget {
  @override
  _QueryFlightsScreenState createState() => _QueryFlightsScreenState();
}

class _QueryFlightsScreenState extends State<QueryFlightsScreen> {
  Future<List<Airport>> _airportsFuture;
  @override
  void initState() {
    _airportsFuture = context.read(isTestMode).apiToUse.getAirports();
    context
        .read(selectedFlightDetails)
        .resetSelectedAirports(); // Prevents dropdown duplicate error: https://i.stack.imgur.com/nX0PJ.png
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
            List<Airport> _depAirports = snapshot.data;
            List<Airport> _arrAirports = snapshot.data;
            Misc().easyDebug({'dep': _depAirports, 'arr': _arrAirports});
            return Consumer(
              builder: (context, watch, child) {
                final _myFlight = watch(selectedFlightDetails);
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
                                SmallHeader(text: "I'm flying from"),
                                DropdownContainer(
                                  airports: _depAirports,
                                  selectedValue: _myFlight.depAirport,
                                  callback: (value) => context
                                      .read(selectedFlightDetails)
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
                                  SmallHeader(text: "to"),
                                  DropdownContainer(
                                    airports: _arrAirports,
                                    selectedValue: _myFlight.arrAirport,
                                    callback: (value) => context
                                        .read(selectedFlightDetails)
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
                                    CustomElevatedButton(
                                      label: 'Ready to fly!',
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

class DropdownContainer extends StatelessWidget {
  final List<Airport> airports;
  final Function callback;
  final Airport selectedValue;

  const DropdownContainer({
    Key key,
    @required this.airports,
    @required this.callback,
    @required this.selectedValue,
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
                        child: Text(airport.name + ' (${airport.iataCode})'),
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
              onChanged: callback,
            ),
          ),
        ),
      ],
    );
  }
}
