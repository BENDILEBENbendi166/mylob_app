import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HotelCard extends StatelessWidget {
  final Map<String, dynamic>? hotel;
  final Map<String, dynamic>? city;
  final bool isSkeleton;
  final LatLng? userLocation;

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
    if (isSkeleton) return _buildSkeleton();
    return _buildRealCard(context);
  }

  Widget _buildSkeleton() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Container(height: 120, color: Colors.grey[300]),
          const SizedBox(height: 8),
          Container(height: 16, width: 120, color: Colors.grey[300]),
          const SizedBox(height: 8),
          Container(height: 14, width: 80, color: Colors.grey[300]),
        ],
      ),
    );
  }

  Widget _buildRealCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hotel!['name'],
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text("${hotel!['stars']} ★ • £${hotel!['basePrice']}"),
            const SizedBox(height: 8),
            Text(city!['name'], style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
