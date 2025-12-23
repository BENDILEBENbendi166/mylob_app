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
