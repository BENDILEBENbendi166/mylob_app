import 'firestore_connect.dart';

class HotelService {
  static Future<List<Map<String, dynamic>>> fetchHotels() async {
    try {
      final snapshot = await FirestoreConnect.db.collection('hotels').get();
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    } catch (e) {
      print("Error fetching hotels: $e");
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> fetchHotelsByCity(
      String city) async {
    try {
      final snapshot = await FirestoreConnect.db
          .collection('hotels')
          .where('city', isEqualTo: city)
          .orderBy('basePrice')
          .get();
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    } catch (e) {
      print("Error fetching hotels by city: $e");
      return [];
    }
  }

  static Future<Map<String, dynamic>?> fetchHotelById(String id) async {
    try {
      final doc = await FirestoreConnect.db.collection('hotels').doc(id).get();

      if (!doc.exists) return null;

      return {
        'id': doc.id,
        ...doc.data()!,
      };
    } catch (e) {
      print("Error fetching hotel by ID: $e");
      return null;
    }
  }
}
