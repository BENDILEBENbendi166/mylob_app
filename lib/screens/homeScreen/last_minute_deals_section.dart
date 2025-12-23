import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LastMinuteDealsSection extends StatelessWidget {
  final List<Map<String, dynamic>> lastMinuteDeals;
  final bool isLoading;

  const LastMinuteDealsSection({
    super.key,
    required this.lastMinuteDeals,
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
            'Last Minute Deals',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: r.spacing),
          _buildDealsList(r),
        ],
      ),
    );
  }

  Widget _buildDealsList(Responsive r) {
    if (isLoading) {
      return _buildSkeletonList();
    }

    if (lastMinuteDeals.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(r.spacing * 2),
          child: const Text('No last minute deals available'),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lastMinuteDeals.length,
      itemBuilder: (context, index) {
        final deal = lastMinuteDeals[index];
        return _buildDealItem(deal);
      },
    );
  }

  Widget _buildDealItem(Map<String, dynamic> deal) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.access_time,
            color: Colors.red.shade600,
            size: 28,
          ),
        ),
        title: Text(
          deal['category'] ?? 'Special Deal',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'Available after 6 PM',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '£${deal['finalPrice'] ?? 0}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              'Final Price',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonList() {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
              ),
              title: Container(
                height: 16,
                width: 120,
                color: Colors.grey[300],
              ),
              subtitle: Container(
                height: 12,
                width: 80,
                color: Colors.grey[300],
              ),
              trailing: Container(
                height: 40,
                width: 60,
                color: Colors.grey[300],
              ),
            ),
          );
        },
      ),
    );
  }
}
