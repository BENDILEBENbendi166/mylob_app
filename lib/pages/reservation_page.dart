import 'package:flutter/material.dart';
import 'package:mylob_app/screens/reservation_screen.dart';

class ReservationPage extends StatelessWidget {
  final String code;
  const ReservationPage({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return ReservationScreen(reservationCode: code);
  }
}
