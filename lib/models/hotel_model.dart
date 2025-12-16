import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  final String id;
  final String name;
  final String city;
  final int stars;
  final String district;
  final List<String> features;
  final List<String> photoUrls;
  final double basePrice; // ✅ added as a proper field

  Hotel({
    required this.id,
    required this.name,
    required this.city,
    required this.stars,
    required this.district,
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
      features: List<String>.from(data['features'] ?? []),
      photoUrls: List<String>.from(data['photoUrls'] ?? []),
      basePrice: (data['basePrice'] ?? 0).toDouble(), // ✅ mapped correctly
    );
  }

  void operator [](String other) {}
}

class Deal {
  final String id;
  final String hotelId;
  final double discountPercent;
  final double finalPrice;
  final int availableRooms;
  final String category;
  final bool activeAfter18;
  final DateTime date; // ✅ added as a proper field

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
      date: (data['date'] as Timestamp).toDate(), // ✅ mapped correctly
    );
  }
}

class City {
  final String id;
  final String name;
  final String country;
  final List<String> popularAttractions;
  final String imageUrl;

  City(
      {required this.id,
      required this.name,
      required this.country,
      required this.popularAttractions,
      required this.imageUrl});

  factory City.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return City(
      id: doc.id,
      name: data['name'],
      country: data['country'],
      popularAttractions: List<String>.from(data['popularAttractions']),
      imageUrl: data['imageUrl'],
    );
  }
}
