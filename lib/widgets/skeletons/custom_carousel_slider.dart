import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'carousel_skeleton.dart';

class CustomCarouselSlider extends StatelessWidget {
  final List<Widget> items;
  final double height;
  final bool autoPlay;
  final bool isLoading;

  const CustomCarouselSlider({
    super.key,
    required this.items,
    this.height = 250,
    this.autoPlay = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CarouselSkeleton(); // shimmer carousel
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        autoPlay: autoPlay,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: items,
    );
  }
}
