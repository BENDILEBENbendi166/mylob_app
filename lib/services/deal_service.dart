import 'firestore_connect.dart';

class DealService {
  static Future<List<Map<String, dynamic>>> fetchDealsByHotel(
      String hotelId) async {
    final snap = await FirestoreConnect.db
        .collection('deals')
        .where('hotelId', isEqualTo: hotelId)
        .orderBy('date')
        .get();

    return snap.docs.map((d) => d.data()).toList();
  }

  static Stream<List<Map<String, dynamic>>> streamDealsByHotel(String hotelId) {
    return FirestoreConnect.db
        .collection('deals')
        .where('hotelId', isEqualTo: hotelId)
        .orderBy('date')
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  static Future<List<Map<String, dynamic>>> fetchAllDeals() async {
    final snap = await FirestoreConnect.db.collection('deals').get();
    return snap.docs.map((d) => d.data()).toList();
  }

  static Future<Map<String, dynamic>?> fetchDealById(String dealId) async {
    final doc = await FirestoreConnect.db.collection('deals').doc(dealId).get();
    return doc.data();
  }
}
