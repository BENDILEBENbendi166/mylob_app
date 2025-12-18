import 'firestore_connect.dart';

class DealService {
  static Future<List<Map<String, dynamic>>> fetchDealsByHotel(
      String hotelId) async {
    try {
      final snapshot = await FirestoreConnect.db
          .collection('deals')
          .where('hotelId', isEqualTo: hotelId)
          .orderBy('date')
          .get();

      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    } catch (e) {
      print("Error fetching deals: $e");
      return [];
    }
  }
}
