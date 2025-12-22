import 'package:flutter/services.dart';
import 'seed_loader.dart';

class SeedValidator {
  static Future<void> validateAll() async {
    final data = await SeedLoader.load();

    // Hotels
    for (final hotel in data['hotels']) {
      for (final photo in hotel['photoUrls']) {
        await _check('assets/images/hotels/$photo');
      }
    }

    // Cities
    for (final city in data['cities']) {
      await _check('assets/images/cities/${city['imageUrl']}');
    }
  }

  static Future<void> _check(String path) async {
    try {
      await rootBundle.load(path);
    } catch (_) {
      throw Exception("❌ Missing asset: $path");
    }
  }
}
