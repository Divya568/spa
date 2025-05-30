import 'package:flutter/foundation.dart';

class BookingProvider with ChangeNotifier {
  DateTime? _bookingDateTime;
  List<String> _services = [];

  DateTime? get bookingDateTime => _bookingDateTime;
  List<String> get services => _services;

  void setBooking(DateTime dateTime, List<String> selectedServices) {
    _bookingDateTime = dateTime;
    _services = selectedServices;
    notifyListeners();
  }

  void clearBooking() {
    _bookingDateTime = null;
    _services = [];
    notifyListeners();
  }
}
