import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ReservationService {
  static final _db = FirebaseFirestore.instance;

  /// Fetch a reservation by its code
  static Future<Map<String, dynamic>?> fetchReservation(
      String reservationCode) async {
    try {
      final snapshot =
          await _db.collection('reservations').doc(reservationCode).get();

      if (!snapshot.exists) return null;
      return snapshot.data();
    } catch (e) {
      debugPrint('Error fetching reservation: $e');
      return null;
    }
  }

  /// Create a new reservation
  static Future<void> createReservation(
    String reservationCode,
    Map<String, dynamic> data,
  ) async {
    try {
      await _db.collection('reservations').doc(reservationCode).set(data);
    } catch (e) {
      debugPrint('Error creating reservation: $e');
    }
  }

  /// Update an existing reservation
  static Future<void> updateReservation(
    String reservationCode,
    Map<String, dynamic> data,
  ) async {
    try {
      await _db.collection('reservations').doc(reservationCode).update(data);
    } catch (e) {
      debugPrint('Error updating reservation: $e');
    }
  }

  /// Delete a reservation
  static Future<void> deleteReservation(String reservationCode) async {
    try {
      await _db.collection('reservations').doc(reservationCode).delete();
    } catch (e) {
      debugPrint('Error deleting reservation: $e');
    }
  }
}
