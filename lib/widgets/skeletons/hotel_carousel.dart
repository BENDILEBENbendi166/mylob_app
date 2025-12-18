import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_card.dart';
import 'package:mylob_app/widgets/responsive.dart';
import 'package:mylob_app/widgets/skeletons/custom_carousel_slider.dart';

class HotelCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> hotels;
  final bool isLoading;

  const HotelCarousel({
    super.key,
    required this.hotels,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Skeleton shimmer carousel
      return CustomCarouselSlider(
        height: 300,
        items: List.generate(
          3,
          (index) => const HotelCard.skeleton(), // skeleton version
        ),
      );
    }

    if (hotels.isEmpty) {
      return const Center(
        child: Text(
          'No hotels available',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }

    return CustomCarouselSlider(
      height: Responsive.isMobile(context) ? 250 : 350,
      items: hotels
          .map((hotel) => GestureDetector(
                onTap: () {
                  // Navigate to hotel detail
                  context.go('/hotel/${hotel['id']}');
                },
                child: HotelCard(hotel: hotel),
              ))
          .toList(),
    );
  }
}
