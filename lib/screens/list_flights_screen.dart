// =============================================================================
// List Flight Results
// =============================================================================

import 'package:flightfinder/components/custom_app_bar.dart';
import 'package:flightfinder/components/flight_card.dart';
import 'package:flightfinder/models/flight.dart';
import 'package:flightfinder/services/mock_api.dart';
import 'package:flutter/material.dart';

class ListFlightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<dynamic>>(
          future: MockApi().getFlights(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              Text("Finding flights...");
            return ListView(
              children: snapshot.data
                  .map(
                    (e) => FlightCard(
                      flight: Flight.fromMap(e),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
