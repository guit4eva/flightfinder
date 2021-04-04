// =============================================================================
// NOTES:
//
//  - To switch between Mock and Real API, use toggle button in the menu
// =============================================================================
import 'package:flightfinder/models/app_mode.dart';
import 'package:flightfinder/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// toggle between test and production mode
final isTestMode = ChangeNotifierProvider<AppMode>((ref) => AppMode());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final testMode = watch(isTestMode);
        return MaterialApp(
          title: 'Flight Finder',
          debugShowCheckedModeBanner:
              testMode.isTestMode, // Show debug banner in test mode
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Color(0xFF2367B4),
            appBarTheme: AppBarTheme(
                color: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                iconTheme: IconThemeData(color: Colors.white)),
          ),
          home: Homepage(),
        );
      },
    );
  }
}
