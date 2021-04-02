import 'package:flutter/foundation.dart';

class AppMode extends ChangeNotifier {
  bool _isTestMode = false;
  bool get isTestMode => _isTestMode;

  void toggleMode() {
    _isTestMode = !_isTestMode;
    print(_isTestMode);
    notifyListeners();
  }
}
