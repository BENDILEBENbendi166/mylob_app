import 'firestore_connect.dart';

class HotelService {
  static Future<List<Map<String, dynamic>>> fetchHotels() async {
    final snapshot = await FirestoreConnect.db.collection('hotels').get();
    return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }

  static Future<List<Map<String, dynamic>>> fetchHotelsByCity(String city) async {
    final snapshot = await FirestoreConnect.db
        .collection('hotels')
        .where('city', isEqualTo: city)
        .orderBy('basePrice')
        .get();
    return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }
}
