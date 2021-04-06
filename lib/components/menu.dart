import 'package:flightfinder/misc/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final _isTestMode = watch(isTestMode);
        return Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: _isTestMode.isTestMode ? Colors.blue : Colors.red),
              child: Text(
                'Switch',
              ),
              onPressed: () {
                context.read(isTestMode).toggleMode();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Currently using:"),
                  Text(
                    "${_isTestMode.isTestMode ? 'MOCK API' : 'REAL API'}",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  )
                ],
              ),
            ),
            if (_isTestMode.isTestMode)
              Column(
                children: [
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "NB: When querying flights in test mode, use:\n\nFrom: JNB\nTo: CPT or DUR",
                    ),
                  ),
                ],
              )
          ],
        );
      },
    );
  }
}
