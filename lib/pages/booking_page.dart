import 'package:flutter/material.dart';
import 'package:mylob_app/screens/booking/booking_screen.dart';

/// Page wrapper for Booking Screen with semantic routing
/// Route: /booking/:dealId
class BookingPage extends StatelessWidget {
  final String dealId;

  const BookingPage({
    super.key,
    required this.dealId,
  });

  @override
  Widget build(BuildContext context) {
    return BookingScreen(dealId: dealId);
  }
}
