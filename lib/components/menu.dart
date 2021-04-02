import 'package:flightfinder/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(
          builder: (context, watch, child) {
            final _isTestMode = watch(isTestMode);
            return ElevatedButton(
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
            );
          },
          // builder
          //         child: ElevatedButton(onPressed: () {

          // }, child: Text()),
        )
      ],
    );
  }
}
