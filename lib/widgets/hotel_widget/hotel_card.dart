import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mylob_app/utils/image_path.dart';

class HotelCard extends StatelessWidget {
  final Map<String, dynamic>? hotel;
  final Map<String, dynamic>? city;
  final LatLng? userLocation;
  final bool isSkeleton;

  const HotelCard({
    super.key,
    required this.hotel,
    required this.city,
    this.userLocation,
  }) : isSkeleton = false;

  const HotelCard.skeleton({super.key})
      : hotel = null,
        city = null,
        userLocation = null,
        isSkeleton = true;

  @override
  Widget build(BuildContext context) {
    if (isSkeleton) return _buildSkeleton(context);
    return _buildRealCard(context);
  }

  // ---------------------------------------------------------
  // SKELETON LOADER
  // ---------------------------------------------------------
  Widget _buildSkeleton(BuildContext context) {
    return Container(
      height: 180, // Fixed height to match real card
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade300,
      ),
      child: Column(
        children: [
          Container(
            height: 120, // Reduced from 150
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          const SizedBox(height: 8),
          Container(height: 14, width: 140, color: Colors.grey.shade300),
          const SizedBox(height: 6),
          Container(height: 12, width: 100, color: Colors.grey.shade300),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // REAL CARD - Copilotic Styled
  // ---------------------------------------------------------
  Widget _buildRealCard(BuildContext context) {
    final imageUrl =
        hotel?['photoUrls'] != null && hotel!['photoUrls'].isNotEmpty
            ? hotel!['photoUrls'][0]
            : 'c1.jpg';
    final price = hotel!['basePrice'];
    final stars = hotel!['stars'];
    final cityName = city!['name'];

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        height: 180,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              spreadRadius: 0,
              offset: const Offset(0, 6),
              color: Colors.black.withOpacity(0.07),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // ---------------------------------------------------------
              // BACKGROUND IMAGE
              // ---------------------------------------------------------
              Positioned.fill(
                child: safeAssetImage(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),

              // ---------------------------------------------------------
              // SUBTLE GRADIENT OVERLAY - Removed tri-color
              // ---------------------------------------------------------
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.01),
                        Colors.black.withOpacity(0.35),
                      ],
                    ),
                  ),
                ),
              ),

              // ---------------------------------------------------------
              // CONTENT
              // ---------------------------------------------------------
              Positioned(
                left: 14,
                right: 14,
                bottom: 14,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CITY BADGE
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        cityName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // HOTEL NAME
                    Text(
                      hotel!['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // STARS + PRICE
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "$stars ★",
                            style: const TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "£$price",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // OPTIONAL DISTANCE
                    if (userLocation != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        _distanceText(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.92),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // DISTANCE CALCULATION
  // ---------------------------------------------------------
  String _distanceText() {
    final hotelLat = hotel!['latitude'];
    final hotelLng = hotel!['longitude'];

    final dx = (hotelLat - userLocation!.latitude).abs();
    final dy = (hotelLng - userLocation!.longitude).abs();
    final approx = (dx + dy) * 111; // rough km estimate

    return "${approx.toStringAsFixed(1)} km away";
  }
}
