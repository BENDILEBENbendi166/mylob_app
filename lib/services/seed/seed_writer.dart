import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mylob_app/models/hotel_model.dart';
import 'package:mylob_app/services/seed/seed_loader.dart';

Future<void> writeHotel(Hotel hotel) async {
  await FirebaseFirestore.instance.collection('hotels').doc(hotel.id).set({
    'name': hotel.name,
    'city': hotel.city,
    'stars': hotel.stars,
    'district': hotel.district,
    'latitude': hotel.latitude,
    'longitude': hotel.longitude,
    'features': hotel.features,
    'photoUrls': hotel.photoUrls,
    'basePrice': hotel.basePrice,
  });
}

Future<void> writeCity(City city) async {
  await FirebaseFirestore.instance.collection('cities').doc(city.id).set({
    'name': city.name,
    'country': city.country,
    'imageUrl': city.imageUrl,
    'popularAttractions': city.popularAttractions
        .map((a) => {
              'name': a.name,
              'latitude': a.latitude,
              'longitude': a.longitude,
            })
        .toList(),
  }, SetOptions(merge: true));
}

Future<void> writeDeal(Deal deal) async {
  await FirebaseFirestore.instance.collection('deals').doc(deal.id).set({
    'hotelId': deal.hotelId,
    'discountPercent': deal.discountPercent,
    'finalPrice': deal.finalPrice,
    'availableRooms': deal.availableRooms,
    'category': deal.category,
    'activeAfter18': deal.activeAfter18,
    'date': Timestamp.fromDate(deal.date),
  }, SetOptions(merge: true));
}

Future<void> seedAll() async {
  final data = await SeedLoader.load();

  // Cities
  for (final c in data['cities']) {
    final city = City(
      id: c['id'],
      name: c['name'],
      country: c['country'],
      imageUrl: c['imageUrl'],
      popularAttractions: (c['popularAttractions'] as List)
          .map((a) => Attraction.fromMap(a))
          .toList(),
    );
    await writeCity(city);
  }

  // Hotels
  for (final h in data['hotels']) {
    final hotel = Hotel(
      id: h['id'],
      name: h['name'],
      city: h['city'],
      stars: h['stars'],
      district: h['district'],
      latitude: h['latitude'],
      longitude: h['longitude'],
      features: List<String>.from(h['features']),
      photoUrls: List<String>.from(h['photoUrls']),
      basePrice: h['basePrice'],
    );
    await writeHotel(hotel);
  }

  // Deals
  for (final d in data['deals']) {
    final deal = Deal(
      id: d['id'],
      hotelId: d['hotelId'],
      discountPercent: d['discountPercent'],
      finalPrice: d['finalPrice'],
      availableRooms: d['availableRooms'],
      category: d['category'],
      activeAfter18: d['activeAfter18'],
      date: DateTime.parse(d['date']),
    );
    await writeDeal(deal);
  }
}
