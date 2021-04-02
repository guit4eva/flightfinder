import 'package:flightfinder/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ListFlightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Text("List Flights"),
    );
  }
}
