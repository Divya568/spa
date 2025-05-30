import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  bool _locationEnabled = false;

  bool get locationEnabled => _locationEnabled;

  void enableLocation() {
    // Simulate enabling location
    _locationEnabled = true;
    notifyListeners();
  }
}
