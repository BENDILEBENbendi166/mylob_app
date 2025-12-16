import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarouselSlider extends StatelessWidget {
  final List<Widget> items;
  final double height;
  final bool autoPlay;

  const CustomCarouselSlider({
    super.key,
    required this.items,
    this.height = 250,
    this.autoPlay = true,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        autoPlay: autoPlay,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 16 / 9,
      ),
      items: items,
    );
  }
}
