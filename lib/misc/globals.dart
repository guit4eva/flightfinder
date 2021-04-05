import 'package:flightfinder/models/app_mode.dart';
import 'package:flightfinder/models/flight.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isTestMode = ChangeNotifierProvider<AppMode>((ref) => AppMode());
final selectedFlightDetails = ChangeNotifierProvider<Flight>((ref) => Flight());
