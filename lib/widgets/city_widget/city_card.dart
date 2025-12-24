import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    final attractions = city?['popularAttractions'] as List<dynamic>? ?? [];

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: isSkeleton || city == null
          ? null
          : () => context.go('/cities/${city!['id']}'),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Skeletonizer(
          enabled: isSkeleton,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ✅ IMAGE
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: SizedBox(
                  height: 120,
                  child: isSkeleton
                      ? Container(
                          color: Colors.grey[300],
                        )
                      : safeAssetImage(
                          city?['imageUrl'] ?? 'coventry.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),

              // ✅ NAME + ATTRACTIONS - constrained height with tighter spacing
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: isSkeleton
                    ? Container(
                        height: 18,
                        width: 100,
                        color: Colors.grey[300],
                      )
                    : SizedBox(
                        height: 36, // Reduced from 42 to 36 to prevent overflow
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              city?['name'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14, // Reduced from 15 to 14
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 1), // Reduced from 2 to 1
                            Text(
                              "${attractions.length} attractions",
                              style: TextStyle(
                                fontSize: 11, // Reduced from 12 to 11
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
