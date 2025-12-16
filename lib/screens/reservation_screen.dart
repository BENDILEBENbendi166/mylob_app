import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/reservation/confirmation_badge.dart';
import 'package:mylob_app/widgets/reservation/reservation_summary.dart';

class ReservationScreen extends StatelessWidget {
  final String reservationCode;
  const ReservationScreen({super.key, required this.reservationCode});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch reservation details
    final reservation = {};

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReservationSummary(reservation: reservation[reservation]),
          const SizedBox(height: 20),
          const ConfirmationBadge(),
        ],
      ),
    );
  }
}
