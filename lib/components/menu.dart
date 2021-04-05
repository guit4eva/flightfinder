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
                _isTestMode.isTestMode
                    ? 'Switch to production mode'
                    : 'Switch to test mode',
              ),
              onPressed: () {
                context.read(isTestMode).toggleMode();
              },
              // builder
              //         child: ElevatedButton(onPressed: () {

              // }, child: Text()),
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
