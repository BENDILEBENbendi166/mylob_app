import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_card.dart';

class HomeDealsSection extends StatelessWidget {
  final List<Map<String, dynamic>> hotels;
  final List<Map<String, dynamic>> cities;
  final List<Map<String, dynamic>> deals;
  final bool isLoading;

  const HomeDealsSection({
    super.key,
    required this.hotels,
    required this.cities,
    required this.deals,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Last‑Minute Hotel Deals',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: r.spacing),
          _buildHotelGrid(r),
          SizedBox(height: r.spacing * 2),
        ],
      ),
    );
  }

  Widget _buildHotelGrid(Responsive r) {
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

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: gridDelegate,
      itemCount: hotels.length,
      itemBuilder: (_, index) {
        final hotel = hotels[index];

        final city = cities.firstWhere(
          (c) => c['name'] == hotel['city'],
          orElse: () => {
            'id': 'unknown',
            'name': hotel['city'],
            'popularAttractions': [],
            'imageUrl': '',
          },
        );

        return HotelCard(
          hotel: hotel,
          city: city,
          userLocation: null,
        );
      },
    );
  }
}
