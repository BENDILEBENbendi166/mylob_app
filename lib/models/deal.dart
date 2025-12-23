import 'package:cloud_firestore/cloud_firestore.dart';

//
// ✅ DEAL MODEL
//
class Deal {
  final String id;
  final String hotelId;
  final double discountPercent;
  final double finalPrice;
  final int availableRooms;
  final String category;
  final bool activeAfter18;
  final DateTime date;

  Deal({
    required this.id,
    required this.hotelId,
    required this.discountPercent,
    required this.finalPrice,
    required this.availableRooms,
    required this.category,
    required this.activeAfter18,
    required this.date,
  });

  factory Deal.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Deal(
      id: doc.id,
      hotelId: data['hotelId'] ?? '',
      discountPercent: (data['discountPercent'] ?? 0).toDouble(),
      finalPrice: (data['finalPrice'] ?? 0).toDouble(),
      availableRooms: (data['availableRooms'] ?? 0) as int,
      category: data['category'] ?? '',
      activeAfter18: data['activeAfter18'] ?? false,

      // ✅ Handle both Timestamp and ISO string
      date: data['date'] is Timestamp
          ? (data['date'] as Timestamp).toDate()
          : DateTime.tryParse(data['date'] ?? '') ?? DateTime.now(),
    );
  }
}
