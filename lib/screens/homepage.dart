import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 22.0, horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    "Flight Finder",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Titan', fontSize: 46.0),
                  ),
                  Text(
                    "Explore the world",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Titan',
                      fontSize: 22.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TODO: Insert image of plane
                  Placeholder(
                    fallbackHeight: 100.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Column(
                      children: [
                        // TODO: Insert button that routes to find_flights.dart
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/img/general/cloud_footer.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}
