import 'package:flutter/material.dart';
import 'package:mylob_app/utils/image_path.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CityCard extends StatelessWidget {
  final Map<String, dynamic>? city;
  final bool isSkeleton;

  const CityCard({super.key, required this.city}) : isSkeleton = false;
  const CityCard.skeleton({super.key})
      : city = null,
        isSkeleton = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Skeletonizer(
        enabled: isSkeleton,
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: isSkeleton
                  ? Container(
                      height: 120,
                      width: double.infinity,
                      color: Colors.grey[300],
                    )
                  : safeAssetImage(
                      city?['imageUrl'] ?? '',
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isSkeleton
                  ? Container(
                      height: 18,
                      width: 100,
                      color: Colors.grey[300],
                    )
                  : Text(
                      city?['name'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
