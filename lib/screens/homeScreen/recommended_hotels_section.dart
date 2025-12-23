import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_card.dart';

class RecommendedHotelsSection extends StatelessWidget {
  final List<Map<String, dynamic>> hotels;
  final List<Map<String, dynamic>> cities;
  final bool isLoading;

  const RecommendedHotelsSection({
    super.key,
    required this.hotels,
    required this.cities,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    // Get top-rated hotels (sort by stars)
    final topRatedHotels = _getTopRatedHotels();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommended Hotels',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: r.spacing),
          _buildHotelGrid(r, topRatedHotels),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getTopRatedHotels() {
    if (isLoading || hotels.isEmpty) return [];
    
    // Sort by stars (highest first) and take top hotels
    final sortedHotels = List<Map<String, dynamic>>.from(hotels);
    sortedHotels.sort((a, b) {
      final starsA = a['stars'] ?? 0;
      final starsB = b['stars'] ?? 0;
      return starsB.compareTo(starsA);
    });
    
    // Return top 6 hotels
    return sortedHotels.take(6).toList();
  }

  Widget _buildHotelGrid(Responsive r, List<Map<String, dynamic>> topRatedHotels) {
    final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: r.isMobile
          ? 1
          : r.isTablet
              ? 2
              : 3,
      childAspectRatio: r.isDesktop
          ? 1
          : r.isTablet
              ? 0.9
              : 0.8,
      crossAxisSpacing: r.spacing / 2,
      mainAxisSpacing: r.spacing / 2,
    );

    if (isLoading) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: gridDelegate,
        itemCount: 6,
        itemBuilder: (_, __) => const HotelCard.skeleton(),
      );
    }

    if (topRatedHotels.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(r.spacing * 2),
          child: const Text('No hotels available'),
        ),
      );
    }

    // ✅ Create a map for O(1) city lookups to avoid O(n²) complexity
    final cityMap = <String, Map<String, dynamic>>{};
    for (final city in cities) {
      if (city['name'] != null) {
        cityMap[city['name']] = city;
      }
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: gridDelegate,
      itemCount: topRatedHotels.length,
      itemBuilder: (_, index) {
        final hotel = topRatedHotels[index];

        final city = cityMap[hotel['city']] ?? {
          'id': 'unknown',
          'name': hotel['city'],
          'popularAttractions': [],
          'imageUrl': '',
        };

        return HotelCard(
          hotel: hotel,
          city: city,
          userLocation: null,
        );
      },
    );
  }
}
