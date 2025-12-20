import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:mylob_app/utils/image_path.dart';

class HotelCard extends StatelessWidget {
  final Map<String, dynamic>? hotel;
  final bool isSkeleton;

  const HotelCard({super.key, required this.hotel}) : isSkeleton = false;
  const HotelCard.skeleton({super.key})
      : hotel = null,
        isSkeleton = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Skeletonizer(
        enabled: isSkeleton,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel image or placeholder
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: isSkeleton
                  ? Container(
                      height: 140,
                      width: double.infinity,
                      color: Colors.grey[300],
                    )
                  : safeAssetImage(hotel!['photoUrls'][0]),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isSkeleton
                      ? Container(
                          height: 16,
                          width: 120,
                          color: Colors.grey[300],
                        )
                      : Text(
                          hotel?['name'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                  const SizedBox(height: 4),
                  isSkeleton
                      ? Row(
                          children: List.generate(
                            5,
                            (index) => Container(
                              margin: const EdgeInsets.only(right: 2),
                              width: 16,
                              height: 16,
                              color: Colors.grey[300],
                            ),
                          ),
                        )
                      : Row(
                          children: List.generate(
                            hotel?['stars'] ?? 0,
                            (index) => const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                          ),
                        ),
                  const SizedBox(height: 4),
                  isSkeleton
                      ? Container(
                          height: 14,
                          width: 80,
                          color: Colors.grey[300],
                        )
                      : Text('${hotel?['basePrice']} £ / night'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
