import 'package:flutter/material.dart';

import '../models/booking_history.dart';
import '../utils/services/booking_history_services.dart';

class BookingHistoryProvider extends ChangeNotifier {
  final _service = BookingHistoryService();
  bool isLoading = false;
  List<BookingHistory> _bookingHistories = [];
  List<BookingHistory> get bookingHistories => _bookingHistories;

  Future<void> getAllBookingHistory() async {
    isLoading = true;
    notifyListeners();

    _bookingHistories =
        (await _service.getBookingHistory()).cast<BookingHistory>();

    isLoading = false;
    notifyListeners();
  }
}
