import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:mylob_app/utils/image_path.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CityHero extends StatelessWidget {
  final Map<String, dynamic>? city;
  final bool isLoading;

  const CityHero({
    super.key,
    required this.city,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    
    // Responsive height for hero section
    final heroHeight = r.isMobile ? 250.0 : r.isTablet ? 300.0 : 350.0;

    if (isLoading) {
      return _buildSkeleton(heroHeight);
    }

    return SizedBox(
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          _buildBackgroundImage(),

          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // City name
          Positioned(
            bottom: r.spacing * 2,
            left: r.spacing,
            right: r.spacing,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city?['name'] ?? 'City',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: r.isDesktop ? 48 : r.isTablet ? 40 : 32,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  city?['country'] ?? '',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: r.isDesktop ? 20 : r.isTablet ? 18 : 16,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        blurRadius: 8.0,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    if (city?['imageUrl'] != null && city!['imageUrl'].toString().isNotEmpty) {
      return safeAssetImage(
        city!['imageUrl'],
        fit: BoxFit.cover,
      );
    }

    // Fallback to a default pattern or color
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(
          Icons.location_city,
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
        color: Colors.grey[300],
        child: const Center(
          child: Icon(
            Icons.location_city,
            size: 80,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
