import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mylob_app/widgets/skeletons/carousel_skeleton.dart';

class CustomCarouselSlider extends StatelessWidget {
  final List<Widget> items;
  final bool autoPlay;
  final bool isLoading;

  const CustomCarouselSlider({
    super.key,
    required this.items,
    this.autoPlay = true,
    this.isLoading = false,
    required double height,
  });

  double _responsiveHeight(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return h.clamp(180.0, 320.0); // ✅ safe adaptive height
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CarouselSkeleton();
    }

    final height = _responsiveHeight(context);
    final isWide = MediaQuery.of(context).size.width > 600;

    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        autoPlay: autoPlay,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: isWide ? 21 / 9 : 16 / 9, // ✅ adaptive ratio
        scrollPhysics: const BouncingScrollPhysics(), // ✅ premium feel
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: items,
    );
  }
}
