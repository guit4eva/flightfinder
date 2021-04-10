import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flightfinder/components/custom_app_bar.dart';
import 'package:flightfinder/components/custom_elevated_button.dart';
import 'package:flightfinder/screens/query_flights.dart';
import 'package:page_transition/page_transition.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      // Override scaffold solid background color with gradient
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0C396D),
            Color(0xFF5E95D4),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          isHomepage: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // -----------------------------------------------------------------
                  // Logo
                  // -----------------------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 8.0),
                    child: Column(
                      children: [
                        Text(
                          "Flight Finder",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'Titan',
                              fontSize: h > 512 ? 46.0 : 36),
                        ),
                        Text(
                          "Realtime flight information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Titan',
                            fontSize: h > 512 ? 22.0 : 16.0,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // -----------------------------------------------------------
                  // Animated Plane Flare
                  // -----------------------------------------------------------
                  Container(
                    width: w / 1.2,
                    height: 100,
                    child: FlareActor("assets/flares/plane.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: "play"),
                  ),
                  SizedBox(
                    height: 22.0,
                  ),
                  // -----------------------------------------------------------
                  // "Ready to fly" button
                  // -----------------------------------------------------------
                  Container(
                    width: w / 1.4,
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          label: "START",
                          bgColor: Theme.of(context).secondaryHeaderColor,
                          textColor: Colors.white,
                          onPressed: () => Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: QueryFlightsScreen(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // -----------------------------------------------------------------
            // Cloud Image Footer (background)
            // -----------------------------------------------------------------
            Image.asset(
              'assets/img/general/cloud_footer.webp',
              fit: BoxFit.cover,
              width: w,
            ),
          ],
        ),
      ),
    );
  }
}
