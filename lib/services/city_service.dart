import 'firestore_connect.dart';

class CityService {
  static Future<List<Map<String, dynamic>>> fetchCities() async {
    final snapshot = await FirestoreConnect.db.collection('cities').get();
    return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }
}
