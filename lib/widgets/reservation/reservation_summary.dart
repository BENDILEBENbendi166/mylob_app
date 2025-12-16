import 'package:flutter/material.dart';

class ReservationSummary extends StatelessWidget {
  final Map<String, dynamic> reservation;
  const ReservationSummary({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reservation Code: ${reservation['code']}'),
            Text('Hotel: ${reservation['hotelName']}'),
            Text('Guest: ${reservation['guestName']}'),
            Text('Check-in: ${reservation['checkIn']}'),
            Text('Check-out: ${reservation['checkOut']}'),
            Text('Total Price: ${reservation['totalPrice']} £'),
          ],
        ),
      ),
    );
  }
}
