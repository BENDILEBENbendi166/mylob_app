import 'package:cloud_firestore/cloud_firestore.dart';

//
// ✅ HOTEL MODEL
//
class Hotel {
  final String id;
  final String name;
  final String city;
  final int stars;
  final String district;
  final double latitude;
  final double longitude;
  final List<String> features;
  final List<String> photoUrls;
  final double basePrice;

  Hotel({
    required this.id,
    required this.name,
    required this.city,
    required this.stars,
    required this.district,
    required this.latitude,
    required this.longitude,
    required this.features,
    required this.photoUrls,
    required this.basePrice,
  });

  factory Hotel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Hotel(
      id: doc.id,
      name: data['name'] ?? '',
      city: data['city'] ?? '',
      stars: (data['stars'] ?? 0) as int,
      district: data['district'] ?? '',
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
      features: List<String>.from(data['features'] ?? []),
      photoUrls: List<String>.from(data['photoUrls'] ?? []),
      basePrice: (data['basePrice'] ?? 0).toDouble(),
    );
  }
}

//
// ✅ DEAL MODEL
//
class Deal {
  final String id;
  final String hotelId;
  final double discountPercent;
  final double finalPrice;
  final int availableRooms;
  final String category;
  final bool activeAfter18;
  final DateTime date;

  Deal({
    required this.id,
    required this.hotelId,
    required this.discountPercent,
    required this.finalPrice,
    required this.availableRooms,
    required this.category,
    required this.activeAfter18,
    required this.date,
  });

  factory Deal.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Deal(
      id: doc.id,
      hotelId: data['hotelId'] ?? '',
      discountPercent: (data['discountPercent'] ?? 0).toDouble(),
      finalPrice: (data['finalPrice'] ?? 0).toDouble(),
      availableRooms: (data['availableRooms'] ?? 0) as int,
      category: data['category'] ?? '',
      activeAfter18: data['activeAfter18'] ?? false,

      // ✅ Handle both Timestamp and ISO string
      date: data['date'] is Timestamp
          ? (data['date'] as Timestamp).toDate()
          : DateTime.tryParse(data['date'] ?? '') ?? DateTime.now(),
    );
  }
}

//
// ✅ ATTRACTION MODEL (nested inside City)
//
class Attraction {
  final String name;
  final double latitude;
  final double longitude;

  Attraction({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Attraction.fromMap(Map<String, dynamic> data) {
    return Attraction(
      name: data['name'] ?? '',
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
    );
  }
}

//
// ✅ CITY MODEL
//
class City {
  final String id;
  final String name;
  final String country;
  final String imageUrl;
  final List<Attraction> popularAttractions;

  City({
    required this.id,
    required this.name,
    required this.country,
    required this.imageUrl,
    required this.popularAttractions,
  });

  factory City.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return City(
      id: doc.id,
      name: data['name'] ?? '',
      country: data['country'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      popularAttractions: (data['popularAttractions'] ?? [])
          .map<Attraction>((a) => Attraction.fromMap(a))
          .toList(),
    );
  }
}
