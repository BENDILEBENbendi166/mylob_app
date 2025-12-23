import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_card.dart';

class HotelsInCityList extends StatelessWidget {
  final List<Map<String, dynamic>> hotels;
  final Map<String, dynamic>? city;
  final bool isLoading;

  const HotelsInCityList({
    super.key,
    required this.hotels,
    required this.city,
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
            'Hotels in ${city?['name'] ?? 'this city'}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: r.spacing),
          _buildHotelsGrid(r),
        ],
      ),
    );
  }

  Widget _buildHotelsGrid(Responsive r) {
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

    if (hotels.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(r.spacing * 2),
          child: Column(
            children: [
              Icon(
                Icons.hotel_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              const Text(
                'No hotels found in this city',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
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
        return HotelCard(
          hotel: hotel,
          city: city,
          userLocation: null,
        );
      },
    );
  }
}
