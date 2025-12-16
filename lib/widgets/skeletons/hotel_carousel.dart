import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_card.dart';
import 'package:mylob_app/widgets/skeletons/custom_carousel_slider.dart';

class HotelCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> hotels;
  const HotelCarousel({super.key, required this.hotels});

  @override
  Widget build(BuildContext context) {
    if (hotels.isEmpty) {
      return const Center(child: Text('No hotels available'));
    }

    return CustomCarouselSlider(
      height: 300,
      items: hotels.map((hotel) => HotelCard(hotel: hotel)).toList(),
    );
  }
}
