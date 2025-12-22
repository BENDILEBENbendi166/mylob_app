import 'firestore_connect.dart';

class HotelService {
  static Stream<List<Map<String, dynamic>>> streamHotels(String cityId) {
    return FirestoreConnect.db
        .collection('hotels')
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  static Future<dynamic> fetchHotelById(String hotelId) async {}
}
