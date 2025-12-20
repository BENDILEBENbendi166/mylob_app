import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mylob_app/seed/assest_validator.dart';
import 'package:mylob_app/seed/seed_loader.dart';

class DatabaseSeeder {
  static final fire = FirebaseFirestore.instance;
  static final rtdb = FirebaseDatabase.instance.ref();

  static Future<void> seedAll() async {
    final seed = await SeedLoader.load();

    await _seedCities(seed['cities']);
    await _seedHotels(seed['hotels']);
    await _seedDeals(seed['deals']);
  }

  static Future<void> _seedCities(Map cities) async {
    for (final entry in cities.entries) {
      final id = entry.key;
      final data = entry.value;

      await AssetValidator.validate(data['imageUrl']);

      await fire.collection('cities').doc(id).set(data);
      await rtdb.child('cities/$id').set(data);
    }
  }

  static Future<void> _seedHotels(Map hotels) async {
    for (final entry in hotels.entries) {
      final id = entry.key;
      final data = entry.value;

      for (final img in data['photoUrls']) {
        await AssetValidator.validate(img);
      }

      await fire.collection('hotels').doc(id).set(data);
      await rtdb.child('hotels/$id').set(data);
    }
  }

  static Future<void> _seedDeals(Map deals) async {
    for (final entry in deals.entries) {
      final id = entry.key;
      final data = entry.value;

      await fire.collection('deals').doc(id).set(data);
      await rtdb.child('deals/$id').set(data);
    }
  }
}
