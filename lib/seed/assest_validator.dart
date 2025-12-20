import 'package:flutter/services.dart';

class AssetValidator {
  static Future<void> validate(String filename) async {
    final path = 'assets/images/$filename';
    try {
      await rootBundle.load(path);
    } catch (_) {
      throw Exception("❌ Missing asset: $path");
    }
  }
}
