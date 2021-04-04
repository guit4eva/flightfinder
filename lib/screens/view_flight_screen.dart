// =============================================================================
// Display detailed flight information (single screen)
// =============================================================================
import 'package:flightfinder/components/custom_app_bar.dart';
import 'package:flightfinder/elements/styles.dart';
import 'package:flightfinder/models/flight.dart';
import 'package:flutter/material.dart';

class ViewFlightScreen extends StatelessWidget {
  const ViewFlightScreen({
    Key key,
    @required this.flight,
  }) : super(key: key);

  final Flight flight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        // TODO: Add airline logo
                        Placeholder(
                          color: Colors.grey,
                          fallbackWidth: MediaQuery.of(context).size.width,
                          fallbackHeight: 200.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '${flight.depAirport} (${flight.depAirportIata})',
                                style: Styles().titleStyle,
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.arrow_right_alt_rounded,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '${flight.arrAirport} (${flight.arrAirportIata})',
                                style: Styles().titleStyle,
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    // TODO: Add flight and airport details
                                    Text("Departs: xxx"),
                                    Text("Arrives: xxx"),
                                    Text("stay tuned...")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0), // TODO: Add map with route displayed
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Placeholder(
                color: Colors.grey,
                fallbackWidth: MediaQuery.of(context).size.width,
                fallbackHeight: 800.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
