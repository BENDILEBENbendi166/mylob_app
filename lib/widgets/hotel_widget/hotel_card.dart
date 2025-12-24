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
    final imageUrl = hotel?['photoUrls'] != null && hotel!['photoUrls'].isNotEmpty
        ? hotel!['photoUrls'][0]
        : 'c1.jpg';
    final price = hotel!['basePrice'];
    final stars = hotel!['stars'];
    final cityName = city!['name'];

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        height: 180, // Fixed height for all cards
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 4),
              color: Colors.black.withOpacity(0.1),
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
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),

              // ---------------------------------------------------------
              // CONTENT
              // ---------------------------------------------------------
              Positioned(
                left: 10,
                right: 10,
                bottom: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CITY BADGE
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        cityName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // HOTEL NAME
                    Text(
                      hotel!['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "£$price",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    // OPTIONAL DISTANCE
                    if (userLocation != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        _distanceText(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 11,
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
