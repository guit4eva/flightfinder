// =============================================================================
// Display detailed flight information (single screen)
// =============================================================================
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flightfinder/components/custom_app_bar.dart';
import 'package:flightfinder/elements/styles.dart';
import 'package:flightfinder/models/airport.dart';
import 'package:flightfinder/models/flight.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class ViewFlightScreen extends StatefulWidget {
  const ViewFlightScreen({
    Key? key,
    required this.flight,
  }) : super(key: key);

  final Flight flight;

  @override
  _ViewFlightScreenState createState() => _ViewFlightScreenState();
}

class _ViewFlightScreenState extends State<ViewFlightScreen> {
  Completer<GoogleMapController> _controller = Completer();
  late Set<Polyline> _polyline = Set();
  late Set<Marker> _allMarkers = Set();
  bool _isLoading = true;
  String _loadingText = "Loading route...";
  late Airport _depAirport;
  late Airport _arrAirport;
  @override
  void initState() {
    super.initState();
    _loadRoute(widget.flight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 200.0,
                                child: GMapContainer(
                                  allMarkers: _allMarkers,
                                  controller: _controller,
                                  isLoading: _isLoading,
                                  loadingText: _loadingText,
                                  polyline: _polyline,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.flight.depAirport!.iataCode} (${DateFormat.Hm().format(widget.flight.depTime!)})',
                                      style: Styles().titleStyle,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Icon(
                                        Icons.arrow_right_alt_rounded,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      '${widget.flight.arrAirport!.iataCode} (${DateFormat.Hm().format(widget.flight.arrTime!)})',
                                      style: Styles().titleStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Divider(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // TODO: Add flight and airport details
                                    Text(
                                        "Departs: ${DateFormat.yMMMd().format(widget.flight.depTime!)}"),
                                    Text(
                                        "Arrives: ${DateFormat.yMMMd().format(widget.flight.arrTime!)}"),
                                    Text(
                                        "Flight: ${widget.flight.number} (${widget.flight.name})")
                                  ],
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
              SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Departure Airport Information"),
                          Text("... stay tuned")
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Arrival Airport Information"),
                          Text("... stay tuned")
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

// TODO: Move below logic out of UI
  Future<void> _loadRoute(Flight flight) async {
    const String _baseUrl = 'https://www.air-port-codes.com/api/v1/single';
    const String _apiSecret = "1a72d2184c405d1";
    const String _apiKey = "5fb0e9d46c";

    try {
      // -----------------------------------------------------------------------
      // Departure Airport
      // -----------------------------------------------------------------------
      Response _depAirportJson = await Dio().get(
          "$_baseUrl?iata=${flight.depAirport!.iataCode}&key=$_apiKey&secret=$_apiSecret");
      _depAirport = Airport.fromMap(_depAirportJson.data['airport']);

      // -----------------------------------------------------------------------
      // Airport Airport
      // -----------------------------------------------------------------------
      Response _arrAirportJson = await Dio().get(
          "$_baseUrl?iata=${flight.arrAirport!.iataCode}&key=$_apiKey&secret=$_apiSecret");
      _arrAirport = Airport.fromMap(_arrAirportJson.data['airport']);
      // -----------------------------------------------------------------------
      // Animate map to new position
      // -----------------------------------------------------------------------
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _depAirport.latLng!,
            zoom: 3.4746,
          ),
        ),
      );
    } catch (error, stacktrace) {
      setState(() {
        _loadingText = "There was an error loading the route.";
      });
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }

    setState(() {
      // -----------------------------------------------------------------------
      // Add markers to map
      // -----------------------------------------------------------------------
      _allMarkers.addAll([
        Marker(
          markerId: MarkerId('departureAirport'),
          draggable: true,
          position: _depAirport.latLng!,
        ),
        Marker(
          markerId: MarkerId('arrivalAirport'),
          draggable: true,
          position: _arrAirport.latLng!,
        ),
      ]);
      // -----------------------------------------------------------------------
      // Add polyline to map
      // -----------------------------------------------------------------------
      _polyline.add(Polyline(
        color: Colors.red,
        width: 4,
        visible: true,
        points: [
          _depAirport.latLng!,
          _arrAirport.latLng!,
        ],
        polylineId: PolylineId("route"),
      ));
      _isLoading = false;
    });
  }
}

class GMapContainer extends StatefulWidget {
  final Completer<GoogleMapController> controller;
  final Set<Polyline> polyline;
  final Set<Marker> allMarkers;
  final bool isLoading;
  final String loadingText;

  const GMapContainer(
      {Key? key,
      required this.controller,
      required this.polyline,
      required this.allMarkers,
      required this.isLoading,
      required this.loadingText})
      : super(key: key);

  @override
  State<GMapContainer> createState() => GMapContainerState();
}

class GMapContainerState extends State<GMapContainer> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-33.567009, 26.5032156),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            widget.controller.complete(controller);
          },
          markers: Set.from(widget.allMarkers),
          polylines: widget.polyline,
        ),
        if (widget.isLoading)
          Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            color: Color(0xAAFFFFFF),
            child: Center(
              child: Text(widget.loadingText),
            ),
          )
      ],
    );
  }
}
