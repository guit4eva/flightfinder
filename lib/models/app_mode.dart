import 'package:flightfinder/services/http_api.dart';
import 'package:flightfinder/services/mock_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppMode extends ChangeNotifier {
  static bool _isTestMode = false;

  get isTestMode => _isTestMode;

  get apiToUse => _isTestMode == true ? MockApi() : HttpApi();

// -----------------------------------------------------------------------------
// Toggle between test and production mode
// -----------------------------------------------------------------------------
  void toggleMode() {
    _isTestMode = !_isTestMode;
    notifyListeners();
  }
}

final appModeProvider = ChangeNotifierProvider<AppMode>((ref) => AppMode());
