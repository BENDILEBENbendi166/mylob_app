import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PopularAttractionsGrid extends StatelessWidget {
  final List<dynamic> attractions;
  final bool isLoading;

  const PopularAttractionsGrid({
    super.key,
    required this.attractions,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Attractions',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: r.spacing),
          _buildAttractionsGrid(r),
        ],
      ),
    );
  }

  Widget _buildAttractionsGrid(Responsive r) {
    if (isLoading) {
      return _buildSkeletonGrid(r);
    }

    if (attractions.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(r.spacing * 2),
          child: const Text(
            'No attractions available',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: r.isMobile
            ? 1
            : r.isTablet
                ? 2
                : 3,
        childAspectRatio: r.isDesktop ? 3 : r.isTablet ? 2.5 : 2,
        crossAxisSpacing: r.spacing / 2,
        mainAxisSpacing: r.spacing / 2,
      ),
      itemCount: attractions.length,
      itemBuilder: (context, index) {
        final attraction = attractions[index];
        return _buildAttractionCard(attraction);
      },
    );
  }

  Widget _buildAttractionCard(Map<String, dynamic> attraction) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.place,
                  color: Colors.red.shade400,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    attraction['name'] ?? 'Unknown',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Lat: ${attraction['latitude']?.toStringAsFixed(4) ?? 'N/A'}, '
              'Lng: ${attraction['longitude']?.toStringAsFixed(4) ?? 'N/A'}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonGrid(Responsive r) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: r.isMobile
              ? 1
              : r.isTablet
                  ? 2
                  : 3,
          childAspectRatio: r.isDesktop ? 3 : r.isTablet ? 2.5 : 2,
          crossAxisSpacing: r.spacing / 2,
          mainAxisSpacing: r.spacing / 2,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 150,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 14,
                    width: 100,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
