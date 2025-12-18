import 'firestore_connect.dart';
import 'package:firebase_database/firebase_database.dart';

class CityService {
  // Firestore
  static Future<List<Map<String, dynamic>>> fetchCitiesFirestore() async {
    try {
      final snapshot = await FirestoreConnect.db.collection('cities').get();
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    } catch (e) {
      print("Error fetching cities from Firestore: $e");
      return [];
    }
  }

  // Realtime Database
  static Future<List<Map<String, dynamic>>> fetchCitiesRTDB() async {
    try {
      final ref = FirebaseDatabase.instance.ref("cities");
      final snapshot = await ref.get();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        return data.entries
            .map((e) => {'id': e.key, ...Map<String, dynamic>.from(e.value)})
            .toList();
      }
      return [];
    } catch (e) {
      print("Error fetching cities from RTDB: $e");
      return [];
    }
  }
}
