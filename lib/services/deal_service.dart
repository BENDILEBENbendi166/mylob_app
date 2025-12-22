import 'firestore_connect.dart';

class DealService {
  static Stream<List<Map<String, dynamic>>> streamDeals(String hotelId) {
    return FirestoreConnect.db
        .collection('deals')
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }
}
