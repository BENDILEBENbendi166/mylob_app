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

  double _adaptiveHeight(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    // ✅ Safe adaptive height for all screens
    if (Responsive.isMobile(context)) return h.clamp(180.0, 260.0);
    if (Responsive.isTablet(context)) return h.clamp(240.0, 320.0);
    return h.clamp(260.0, 360.0); // desktop/web
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CustomCarouselSlider(
        height: _adaptiveHeight(context),
        items: List.generate(
          3,
          (index) => const HotelCard.skeleton(),
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

    final height = _adaptiveHeight(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CustomCarouselSlider(
        height: height,
        items: hotels.map((hotel) {
          return GestureDetector(
            onTap: () => context.go('/hotel/${hotel['id']}'),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: 0.98,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: HotelCard(hotel: hotel),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
