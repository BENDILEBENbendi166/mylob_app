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
      borderRadius: BorderRadius.circular(18),
      onTap: isSkeleton || city == null
          ? null
          : () => context.go('/cities/${city!['id']}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.only(bottom: 10),
        child: Skeletonizer(
          enabled: isSkeleton,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // IMAGE
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(18)),
                child: SizedBox(
                  height: 110,
                  child: isSkeleton
                      ? Container(color: Colors.grey[300])
                      : safeAssetImage(
                          city?['imageUrl'] ?? 'coventry.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 10.0),
                child: isSkeleton
                    ? Container(
                        height: 18,
                        width: 100,
                        color: Colors.grey[300],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            city?['name'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${attractions.length} attractions",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
