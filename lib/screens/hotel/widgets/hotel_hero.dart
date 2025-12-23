import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HotelHero extends StatefulWidget {
  final Map<String, dynamic>? hotel;
  final bool isLoading;

  const HotelHero({
    super.key,
    required this.hotel,
    required this.isLoading,
  });

  @override
  State<HotelHero> createState() => _HotelHeroState();
}

class _HotelHeroState extends State<HotelHero> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    
    // Responsive height for hero section
    final heroHeight = r.isMobile ? 250.0 : r.isTablet ? 300.0 : 400.0;

    if (widget.isLoading) {
      return _buildSkeleton(heroHeight);
    }

    final photoUrls = widget.hotel?['photoUrls'] as List<dynamic>? ?? [];

    if (photoUrls.isEmpty) {
      return _buildFallback(heroHeight);
    }

    // If only one image, show it directly
    if (photoUrls.length == 1) {
      return _buildSingleImage(photoUrls[0], heroHeight);
    }

    // Multiple images - show carousel
    return _buildCarousel(photoUrls, heroHeight);
  }

  Widget _buildCarousel(List<dynamic> photoUrls, double height) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: photoUrls.length,
          options: CarouselOptions(
            height: height,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return _buildImageContainer(photoUrls[index], height);
          },
        ),
        
        // Image counter indicator
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${_currentImageIndex + 1}/${photoUrls.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleImage(String photoUrl, double height) {
    return _buildImageContainer(photoUrl, height);
  }

  Widget _buildImageContainer(String photoUrl, double height) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: Image.asset(
          'assets/images/$photoUrl',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(
                  Icons.hotel,
                  size: 64,
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFallback(double height) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.hotel,
          size: 80,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSkeleton(double height) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
