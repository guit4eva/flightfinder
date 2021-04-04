// =============================================================================
// List Flight Results
// =============================================================================

import 'package:flightfinder/components/custom_app_bar.dart';
import 'package:flightfinder/components/flight_card.dart';
import 'package:flightfinder/main.dart';
import 'package:flightfinder/models/flight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListFlightsScreen extends StatefulWidget {
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
  List<dynamic> _currentFlightList = [];
  @override
  void initState() {
    super.initState();
    // _api.getFlights(_limit, _offset);
    // fetch(_limit, _offset);
    // Update data when bottom of listview is reached
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = 200.0;
      if (maxScroll - currentScroll <= delta && !_isLoading && !_endOfData) {
        print("End reached!");
        setState(() {
          _isLoading = true;
        });

        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _offset = _offset + _docLimit;
            _isLoading = false;
            print('docLimit is $_docLimit, offset is $_offset');
          });
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<dynamic>>(
              future: _appMode.apiToUse.getFlights(
                  currentList: _currentFlightList,
                  docLimit: _docLimit,
                  offset: _offset,
                  callback: _callback),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !_hasInitialised)
                  return Center(child: Text("Finding flights..."));
                if (!snapshot.hasData) return Text("Nothing here...");
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
                                flight: Flight.fromMap(e),
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
              },
            ),
          );
        },
      ),
    );
  }

  void _callback(currentList, endOfData) {
    _currentFlightList = currentList;
    if (endOfData) _endOfData = true;
    print(endOfData);
  }
}
