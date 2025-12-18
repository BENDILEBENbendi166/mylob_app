import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DealCard extends StatelessWidget {
  final Map<String, dynamic>? deal;
  final bool isSkeleton;

  const DealCard({super.key, required this.deal}) : isSkeleton = false;
  const DealCard.skeleton({super.key})
      : deal = null,
        isSkeleton = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange[50],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Skeletonizer(
        enabled: isSkeleton,
        child: ListTile(
          leading: isSkeleton
              ? Container(
                  width: 40,
                  height: 40,
                  color: Colors.grey[300],
                )
              : const Icon(Icons.local_offer, color: Colors.orange),
          title: isSkeleton
              ? Container(
                  height: 18,
                  width: 120,
                  color: Colors.grey[300],
                )
              : Text(deal?['title'] ?? 'Special Deal'),
          subtitle: isSkeleton
              ? Container(
                  height: 14,
                  width: 100,
                  margin: const EdgeInsets.only(top: 6),
                  color: Colors.grey[300],
                )
              : Text('Expires: ${deal?['expiry'] ?? 'N/A'}'),
          trailing: isSkeleton
              ? Container(
                  height: 16,
                  width: 60,
                  color: Colors.grey[300],
                )
              : Text(
                  '${deal?['discount'] ?? 0}% OFF',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
