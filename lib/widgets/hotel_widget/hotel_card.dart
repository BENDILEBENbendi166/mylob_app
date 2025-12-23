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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade300,
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          const SizedBox(height: 12),
          Container(height: 16, width: 140, color: Colors.grey.shade300),
          const SizedBox(height: 8),
          Container(height: 14, width: 100, color: Colors.grey.shade300),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // REAL CARD
  // ---------------------------------------------------------
  Widget _buildRealCard(BuildContext context) {
    final imageUrl = hotel?['photoUrls'] != null && hotel!['photoUrls'].isNotEmpty
        ? hotel!['photoUrls'][0]
        : 'c1.jpg';
    final price = hotel!['basePrice'];
    final stars = hotel!['stars'];
    final cityName = city!['name'];

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 6),
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // ---------------------------------------------------------
              // BACKGROUND IMAGE
              // ---------------------------------------------------------
              safeAssetImage(
                imageUrl,
                fit: BoxFit.cover,
              ),

              // ---------------------------------------------------------
              // GRADIENT OVERLAY
              // ---------------------------------------------------------
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),

              // ---------------------------------------------------------
              // CONTENT
              // ---------------------------------------------------------
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CITY BADGE
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        cityName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // HOTEL NAME
                    Text(
                      hotel!['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // STARS + PRICE
                    Row(
                      children: [
                        Text(
                          "$stars ★",
                          style: const TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "£$price",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    // OPTIONAL DISTANCE
                    if (userLocation != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        _distanceText(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
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
