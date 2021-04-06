// =============================================================================
// No data available
// =============================================================================

import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/general/parachute.webp',
            width: 200.0,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 22.0,
          ),
          Text(
            "Oops, nothing found...",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
