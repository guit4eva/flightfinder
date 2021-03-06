// =============================================================================
// NOTES:
//
//  - To switch between Mock and Real API, use toggle button in the app's menu
// =============================================================================
// import 'package:flightfinder/misc/globals.dart';
// import 'package:flightfinder/models/app_mode.dart';
// import 'package:flightfinder/models/flight.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flightfinder/models/app_mode.dart';
import 'package:flightfinder/screens/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ////////////////
    /// Test Aspect Ratios (Device Preview)
    ///////////////
    DevicePreview(
      enabled: false,
      builder: (context) => ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final appMode = watch(appModeProvider);
      return MaterialApp(
        title: 'Flight Finder',
        debugShowCheckedModeBanner:
            appMode.isTestMode, // Show debug banner in test mode
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xFFDA9310),
          secondaryHeaderColor: Color(0xFF70431E),
          scaffoldBackgroundColor: Color(0xFF2A67AD),
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.grey.shade700),
            bodyText2: TextStyle(color: Colors.grey.shade700),
          ),
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: Homepage(),
      );
    });
  }
}
