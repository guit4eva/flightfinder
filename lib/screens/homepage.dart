import 'package:flare_flutter/flare_actor.dart';
import 'package:flightfinder/components/custom_app_bar.dart';
import 'package:flightfinder/components/custom_elevated_button.dart';
import 'package:flightfinder/screens/list_flights_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isHomepage: true,
      ),
      body: Center(
        child: Column(
          children: [
            // -----------------------------------------------------------------
            // Logo
            // -----------------------------------------------------------------
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 8.0),
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
                  // -----------------------------------------------------------
                  // Animated Plane Flare
                  // -----------------------------------------------------------
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
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
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          label: "Ready to fly!",
                          bgColor: Color(0xFF804004),
                          textColor: Colors.white,
                          onPressed: () => Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                // child: QueryFlightsScreen(),
                                child: ListFlightsScreen()),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // -----------------------------------------------------------------
            // Cloud Image Footer
            // -----------------------------------------------------------------
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
