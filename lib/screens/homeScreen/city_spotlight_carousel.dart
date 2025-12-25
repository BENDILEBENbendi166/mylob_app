import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:mylob_app/widgets/city_widget/city_card.dart';

class CitySpotlightCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> cities;
  final bool isLoading;

  const CitySpotlightCarousel({
    super.key,
    required this.cities,
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
            'Explore Cities',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: r.spacing),
          _buildCarousel(r),
        ],
      ),
    );
  }

  Widget _buildCarousel(Responsive r) {
    if (isLoading) {
      return _buildSkeletonCarousel(r);
    }

    if (cities.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(r.spacing * 2),
          child: const Text('No cities available'),
        ),
      );
    }

    return CarouselSlider.builder(
      itemCount: cities.length,
      options: CarouselOptions(
        height: r.isMobile ? 220 : 260, // Increased height for carousel
        viewportFraction: r.isMobile
            ? 0.8
            : r.isTablet
                ? 0.42
                : 0.28, // Slightly reduced fraction for larger cards
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      itemBuilder: (context, index, realIndex) {
        final city = cities[index];
        return CityCard(city: city);
      },
    );
  }

  Widget _buildSkeletonCarousel(Responsive r) {
    return CarouselSlider.builder(
      itemCount: 3,
      options: CarouselOptions(
        height: r.isMobile ? 200 : 220,
        viewportFraction: r.isMobile
            ? 0.85
            : r.isTablet
                ? 0.45
                : 0.3,
        enlargeCenterPage: true,
      ),
      itemBuilder: (context, index, realIndex) {
        return const CityCard.skeleton();
      },
    );
  }
}
