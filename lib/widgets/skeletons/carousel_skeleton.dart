import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CarouselSkeleton extends StatelessWidget {
  final int itemCount;
  const CarouselSkeleton({super.key, this.itemCount = 3});

  double _responsiveHeight(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    // ✅ Adaptive height with safe bounds
    return h.clamp(180.0, 320.0);
  }

  @override
  Widget build(BuildContext context) {
    final height = _responsiveHeight(context);

    return Skeletonizer(
      child: CarouselSlider(
        items: List.generate(
          itemCount,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[300]!, Colors.grey[200]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
        options: CarouselOptions(
          height: height,
          autoPlay: true,
          autoPlayCurve: Curves.easeInOut,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          viewportFraction: 0.75,
        ),
      ),
    );
  }
}
