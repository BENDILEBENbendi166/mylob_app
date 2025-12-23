import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:intl/intl.dart';

class BookingSummary extends StatelessWidget {
  final Map<String, dynamic>? deal;
  final Map<String, dynamic>? hotel;
  final Map<String, dynamic>? city;
  final bool isLoading;

  const BookingSummary({
    super.key,
    required this.deal,
    required this.hotel,
    required this.city,
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
            'Booking Summary',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: r.spacing),
          _buildSummaryCard(context, r),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, Responsive r) {
    if (isLoading) {
      return _buildSkeletonCard();
    }

    if (deal == null || hotel == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Booking information not available'),
        ),
      );
    }

    final dateFormat = DateFormat('EEE, MMM dd, yyyy');
    final dealDate = deal!['date'] is DateTime
        ? deal!['date'] as DateTime
        : DateTime.tryParse(deal!['date']?.toString() ?? '') ?? DateTime.now();
    
    final checkInDate = dealDate;
    final checkOutDate = dealDate.add(const Duration(days: 1));
    
    final finalPrice = deal!['finalPrice'] ?? 0;
    final discountPercent = deal!['discountPercent'] ?? 0;
    final category = deal!['category'] ?? 'Special Deal';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel name with icon
            Row(
              children: [
                Icon(
                  Icons.hotel,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    hotel!['name'] ?? 'Hotel',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Location
            if (city != null)
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${hotel!['district'] ?? ''}, ${city!['name'] ?? ''}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),

            // Deal category badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_offer,
                    size: 16,
                    color: Colors.orange.shade800,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    category,
                    style: TextStyle(
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$discountPercent% OFF',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Check-in and Check-out
            Row(
              children: [
                Expanded(
                  child: _buildDateInfo(
                    'Check-in',
                    dateFormat.format(checkInDate),
                    Icons.login,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateInfo(
                    'Check-out',
                    dateFormat.format(checkOutDate),
                    Icons.logout,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),

            // Price summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '£$finalPrice',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Payment at hotel • No upfront charges',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateInfo(String label, String date, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: Colors.blue.shade700,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            date,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Skeletonizer(
      enabled: true,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 24, width: 200, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Container(height: 16, width: 150, color: Colors.grey[300]),
              const SizedBox(height: 20),
              Container(height: 40, width: 100, color: Colors.grey[300]),
            ],
          ),
        ),
      ),
    );
  }
}
