import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mylob_app/models/hotel_model.dart';
import 'package:mylob_app/services/seed/seed_writer.dart';

// ---------------------------------------------------------
// LOAD SEED JSON
// ---------------------------------------------------------
Future<Map<String, dynamic>> loadSeedJson() async {
  final jsonString = await rootBundle.loadString('assets/seed/seed.json');
  return json.decode(jsonString);
}

// ---------------------------------------------------------
// SEED ALL
// ---------------------------------------------------------
Future<void> seedAll() async {
  final data = await loadSeedJson();

  // -------------------------
  // Cities
  // -------------------------
  final cities = data['cities'] as List<dynamic>;
  for (final cityMap in cities) {
    final city = City(
      id: cityMap['id'],
      name: cityMap['name'],
      country: cityMap['country'],
      imageUrl: cityMap['imageUrl'],
      popularAttractions: (cityMap['popularAttractions'] as List<dynamic>)
          .map((a) => Attraction.fromMap(a))
          .toList(),
    );

    try {
      await writeCity(city);
    } catch (e) {
      print("❌ Failed to write city ${city.id}: $e");
      print("📦 Seeding cities...");
      for (final cityMap in cities) {
        print(" → ${cityMap['id']}");
        await writeCity(city);
      }
    }
  }

  final hotels = data['hotels'] as List<dynamic>;
  for (final hotelMap in hotels) {
    final hotel = Hotel(
      id: hotelMap['id'],
      name: hotelMap['name'],
      city: hotelMap['city'],
      stars: hotelMap['stars'],
      district: hotelMap['district'],
      latitude: hotelMap['latitude'],
      longitude: hotelMap['longitude'],
      features: List<String>.from(hotelMap['features']),
      photoUrls: List<String>.from(hotelMap['photoUrls']),
      basePrice: hotelMap['basePrice'],
    );

    try {
      await writeHotel(hotel);
    } catch (e) {
      print("❌ Failed to write city ${hotel.id}: $e");
      print("📦 Seeding hotels...");
      for (final hotelMap in hotels) {
        print(" → ${hotelMap['id']}");
        await writeHotel(hotel);
      }
    }
  }

  final deals = data['deals'] as List<dynamic>;
  for (final dealMap in deals) {
    final deal = Deal(
      id: dealMap['id'],
      hotelId: dealMap['hotelId'],
      discountPercent: dealMap['discountPercent'],
      finalPrice: dealMap['finalPrice'],
      availableRooms: dealMap['availableRooms'],
      category: dealMap['category'],
      activeAfter18: dealMap['activeAfter18'],
      date: DateTime.parse(dealMap['date']),
    );
    try {
      await writeDeal(deal);
    } catch (e) {
      print("❌ Failed to write city ${deal.id}: $e");
      print("📦 Seeding deals...");
      for (final dealMap in deals) {
        print(" → ${dealMap['id']}");
        await writeDeal(deal);
      }
    }
  }
  print("🎉 All seeding completed!");
}
