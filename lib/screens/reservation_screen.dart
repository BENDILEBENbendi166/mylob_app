import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/reservation/confirmation_badge.dart';
import 'package:mylob_app/widgets/reservation/reservation_summary.dart';
import 'package:mylob_app/services/reservation_service.dart';

class ReservationScreen extends StatefulWidget {
  final String reservationCode;
  const ReservationScreen({super.key, required this.reservationCode});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  Map<String, dynamic>? reservation;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReservation();
  }

  Future<void> _fetchReservation() async {
    final result =
        await ReservationService.fetchReservation(widget.reservationCode);

    if (!mounted) return;

    setState(() {
      reservation = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Reservation Details')),
        body: Center(
          child: Card(
            elevation: 6,
            margin: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 120,
                    width: 260,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (reservation == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Reservation not found',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Reservation Details')),
      body: Center(
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ReservationSummary(reservation: reservation!),
                const SizedBox(height: 20),
                const ConfirmationBadge(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
