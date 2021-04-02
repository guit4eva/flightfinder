import 'package:flightfinder/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class QueryFlightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
          child: Text(
        "Find your perfect flight:",
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
