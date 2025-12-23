import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DealHero extends StatelessWidget {
  final Map<String, dynamic>? hotel;
  final Map<String, dynamic>? deal;
  final bool isLoading;

  const DealHero({
    super.key,
    required this.hotel,
    required this.deal,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    
    // Responsive height for hero section
    final heroHeight = r.isMobile ? 280.0 : r.isTablet ? 320.0 : 380.0;

    if (isLoading) {
      return _buildSkeleton(heroHeight);
    }

    return SizedBox(
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background hotel image
          _buildBackgroundImage(),

          // Dark gradient overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Discount badge overlay
          Positioned(
            top: r.spacing * 2,
            right: r.spacing * 2,
            child: _buildDiscountBadge(context),
          ),

          // Hotel name and deal info at bottom
          Positioned(
            bottom: r.spacing * 2,
            left: r.spacing,
            right: r.spacing,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Hotel name
                Text(
                  hotel?['name'] ?? 'Hotel Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: r.isDesktop ? 32 : r.isTablet ? 28 : 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.8),
                        offset: const Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Deal category
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    deal?['category'] ?? 'Special Deal',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
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
    final photoUrls = hotel?['photoUrls'] as List<dynamic>? ?? [];
    
    if (photoUrls.isNotEmpty) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Image.asset(
          'assets/images/${photoUrls[0]}',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallback();
          },
        ),
      );
    }

    return _buildFallback();
  }

  Widget _buildFallback() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.local_offer,
          size: 80,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildDiscountBadge(BuildContext context) {
    final discountPercent = deal?['discountPercent'] ?? 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red.shade600,
            Colors.red.shade800,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$discountPercent%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
          const Text(
            'OFF',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
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
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
