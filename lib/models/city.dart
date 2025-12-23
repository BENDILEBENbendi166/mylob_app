import 'package:cloud_firestore/cloud_firestore.dart';
import 'attraction.dart';

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
