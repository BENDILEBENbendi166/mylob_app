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
