import 'package:mylob_app/services/firestore_connect.dart';
import 'seed_loader.dart';

class SeedWriter {
  static Future<void> writeAll() async {
    final data = await SeedLoader.load();

    // Hotels
    for (final hotel in data['hotels']) {
      await FirestoreConnect.db
          .collection('hotels')
          .doc(hotel['id'])
          .set(hotel);
    }

    // Deals
    for (final deal in data['deals']) {
      await FirestoreConnect.db.collection('deals').doc(deal['id']).set(deal);
    }

    // Cities
    for (final city in data['cities']) {
      await FirestoreConnect.db.collection('cities').doc(city['id']).set(city);
    }
  }
}
