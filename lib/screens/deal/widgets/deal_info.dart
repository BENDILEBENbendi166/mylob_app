import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:intl/intl.dart';

class DealInfo extends StatelessWidget {
  final Map<String, dynamic>? deal;
  final Map<String, dynamic>? hotel;
  final Map<String, dynamic>? city;
  final bool isLoading;

  const DealInfo({
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
            'Deal Breakdown',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: r.spacing),
          _buildInfoCard(context, r),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, Responsive r) {
    if (isLoading) {
      return _buildSkeletonCard();
    }

    if (deal == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Deal information not available'),
        ),
      );
    }

    final basePrice = hotel?['basePrice'] ?? 0;
    final discountPercent = deal!['discountPercent'] ?? 0;
    final finalPrice = deal!['finalPrice'] ?? 0;
    final category = deal!['category'] ?? 'Special Deal';
    final availableRooms = deal!['availableRooms'] ?? 0;
    final activeAfter18 = deal!['activeAfter18'] ?? false;
    
    final dateFormat = DateFormat('EEEE, MMM dd, yyyy');
    final dealDate = deal!['date'] is DateTime
        ? deal!['date'] as DateTime
        : DateTime.tryParse(deal!['date']?.toString() ?? '') ?? DateTime.now();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category
            Row(
              children: [
                Icon(
                  Icons.local_offer,
                  color: Colors.orange.shade700,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            // Price breakdown
            _buildPriceRow('Original Price', '£$basePrice', false),
            const SizedBox(height: 12),
            _buildPriceRow(
              'Discount ($discountPercent%)',
              '-£${(basePrice * discountPercent / 100).toStringAsFixed(2)}',
              false,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            _buildPriceRow('Final Price', '£$finalPrice', true),
            
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 20),

            // Date
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Colors.grey[700],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Valid Date',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateFormat.format(dealDate),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            if (activeAfter18) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.blue.shade700,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Available after 6:00 PM',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),

            // Rooms left badge
            _buildRoomsLeftBadge(availableRooms),

            if (city != null) ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 20,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${hotel?['district'] ?? ''}, ${city!['name'] ?? ''}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String price, bool isFinal, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isFinal ? 18 : 16,
            fontWeight: isFinal ? FontWeight.bold : FontWeight.w500,
            color: color,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: isFinal ? 28 : 16,
            fontWeight: isFinal ? FontWeight.bold : FontWeight.w600,
            color: color ?? (isFinal ? Colors.green.shade700 : null),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomsLeftBadge(int availableRooms) {
    final isUrgent = availableRooms <= 3;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isUrgent ? Colors.red.shade50 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUrgent ? Colors.red.shade300 : Colors.green.shade300,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUrgent ? Icons.warning_amber_rounded : Icons.check_circle,
            color: isUrgent ? Colors.red.shade700 : Colors.green.shade700,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUrgent ? 'Almost Sold Out!' : 'Available Rooms',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isUrgent ? Colors.red.shade700 : Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$availableRooms ${availableRooms == 1 ? 'room' : 'rooms'} left',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isUrgent ? Colors.red.shade900 : Colors.green.shade900,
                  ),
                ),
              ],
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 24, width: 200, color: Colors.grey[300]),
              const SizedBox(height: 20),
              Container(height: 20, width: 150, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Container(height: 20, width: 150, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Container(height: 28, width: 120, color: Colors.grey[300]),
            ],
          ),
        ),
      ),
    );
  }
}
