import 'firestore_connect.dart';

class CityService {
  static Future<List<Map<String, dynamic>>> fetchCitiesFirestore() async {
    final snap = await FirestoreConnect.db.collection('cities').get();
    return snap.docs.map((d) {
      final data = d.data();
      data['id'] = d.id;
      return data;
    }).toList();
  }

  static Stream<List<Map<String, dynamic>>> streamCities(String cityId) {
    return FirestoreConnect.db
        .collection('cities')
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  static Future<Map<String, dynamic>?> fetchCityById(String id) async {
    final doc = await FirestoreConnect.db.collection('cities').doc(id).get();
    return doc.data();
  }

  static Stream<Map<String, dynamic>?> streamCityById(String id) {
    return FirestoreConnect.db
        .collection('cities')
        .doc(id)
        .snapshots()
        .map((d) => d.data());
  }
}
