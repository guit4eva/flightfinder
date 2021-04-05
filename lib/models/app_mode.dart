import 'package:flightfinder/services/http_api.dart';
import 'package:flightfinder/services/mock_api.dart';
import 'package:flutter/foundation.dart';

class AppMode extends ChangeNotifier {
  static bool _isTestMode = false;
  var apiToUse = MockApi();

  get isTestMode => _isTestMode;

// -----------------------------------------------------------------------------
// Toggle between test and production mode
// -----------------------------------------------------------------------------
  void toggleMode() {
    _isTestMode = !_isTestMode;
    _isTestMode == true ? apiToUse = MockApi() : HttpApi();
    notifyListeners();
  }
}
