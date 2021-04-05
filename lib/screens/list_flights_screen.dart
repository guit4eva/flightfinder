// =============================================================================
// List Flight Results
// =============================================================================

import 'package:flightfinder/components/custom_app_bar.dart';
import 'package:flightfinder/components/flight_card.dart';
import 'package:flightfinder/misc/globals.dart';
import 'package:flightfinder/models/flight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListFlightsScreen extends StatefulWidget {
  const ListFlightsScreen({
    Key key,
  }) : super(key: key);

  @override
  _ListFlightsScreenState createState() => _ListFlightsScreenState();
}

class _ListFlightsScreenState extends State<ListFlightsScreen> {
  ScrollController _scrollController = ScrollController();
  int _docLimit = 20;
  int _offset = 0;
  bool _isLoading = false;
  bool _hasInitialised = false;
  bool _endOfData = false;
  List<Flight> _currentFlightList = [];
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = 200.0;
      if (maxScroll - currentScroll <= delta && !_isLoading && !_endOfData) {
        print("End reached!");
        setState(() {
          _isLoading = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Consumer(
        builder: (context, watch, child) {
          final _appMode = watch(isTestMode);
          final _myFlight = watch(selectedFlightDetails);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<Flight>>(
                future: _appMode.apiToUse.getFlights(
                  currentList: _currentFlightList,
                  docLimit: _docLimit,
                  offset: _offset,
                  callback: _callback,
                  departureAirport: _myFlight.depAirport,
                  arrivalAirport: _myFlight.arrAirport,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      !_hasInitialised)
                    return Center(child: Text("Finding flights..."));
                  if (snapshot.hasData && snapshot.data.length != 0) {
                    _hasInitialised = true;
                    return Column(
                      children: [
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            controller: _scrollController,
                            children: snapshot.data
                                .map(
                                  (e) => FlightCard(
                                    flight: e,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        if (_isLoading)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                      ],
                    );
                  }
                  return Center(child: Text("No flights found..."));
                }),
          );
        },
      ),
    );
  }

  void _callback(currentList, endOfData) {
    // print(currentList);
    // _currentFlightList = currentList;
    // if (endOfData) _endOfData = true;
    _isLoading = false;
  }
}
