import 'package:flightfinder/screens/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Finder',
      debugShowCheckedModeBanner: false, // Hide debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFF2367B4),
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),
      home: Homepage(),
    );
  }
}
