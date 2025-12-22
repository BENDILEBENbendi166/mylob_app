import 'firestore_connect.dart';

class HotelService {
  static Future<List<Map<String, dynamic>>> fetchHotels() async {
    final snap = await FirestoreConnect.db.collection('hotels').get();
    return snap.docs.map((d) => d.data()).toList();
  }

  static Future<List<Map<String, dynamic>>> fetchHotelsByCity(
      String cityName) async {
    final snap = await FirestoreConnect.db
        .collection('hotels')
        .where('city', isEqualTo: cityName)
        .get();

    return snap.docs.map((d) => d.data()).toList();
  }

  static Stream<List<Map<String, dynamic>>> streamHotelsByCity(
      String cityName) {
    return FirestoreConnect.db
        .collection('hotels')
        .where('city', isEqualTo: cityName)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  static Future<Map<String, dynamic>?> fetchHotelById(String hotelId) async {
    final doc =
        await FirestoreConnect.db.collection('hotels').doc(hotelId).get();
    return doc.data();
  }
}
