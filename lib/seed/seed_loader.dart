import 'dart:convert';
import 'package:flutter/services.dart';

class SeedLoader {
  static Future<Map<String, dynamic>> load() async {
    final raw = await rootBundle.loadString('assets/seed/seed.json');
    return json.decode(raw);
  }
}
