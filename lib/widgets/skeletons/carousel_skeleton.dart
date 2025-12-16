import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:skeletonizer/skeletonizer.dart';




class CarouselSkeleton extends StatelessWidget {
  const CarouselSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: CarouselSlider(
        items: List.generate(
          6,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
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
            height: 200, // match HotelCard image height
          ),
        ),
        options: CarouselOptions(
          height: 280,
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
