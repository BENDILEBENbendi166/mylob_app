import 'firestore_connect.dart';

class CityService {
  static Stream<List<Map<String, dynamic>>> streamCities(String cityId) {
    return FirestoreConnect.db
        .collection('cities')
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }
}
