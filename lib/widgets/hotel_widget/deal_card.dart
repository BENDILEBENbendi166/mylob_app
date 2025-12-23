import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mylob_app/utils/image_path.dart';

class DealCard extends StatelessWidget {
  final Map<String, dynamic>? hotel;
  final Map<String, dynamic>? deal;
  final Map<String, dynamic>? city;
  final bool isSkeleton;

  const DealCard({
    super.key,
    required this.hotel,
    required this.deal,
    required this.city,
  }) : isSkeleton = false;

  const DealCard.skeleton({super.key})
      : hotel = null,
        deal = null,
        city = null,
        isSkeleton = true;

  @override
  Widget build(BuildContext context) {
    if (isSkeleton) return _buildSkeleton();
    return _buildRealCard(context);
  }

  // ---------------------------------------------------------
  // SKELETON UI
  // ---------------------------------------------------------
  Widget _buildSkeleton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fake image
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fake discount badge
                Container(
                  height: 18,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                const SizedBox(height: 12),

                // Fake hotel name
                Container(
                  height: 16,
                  width: 140,
                  color: Colors.grey.shade300,
                ),

                const SizedBox(height: 8),

                // Fake subtitle
                Container(
                  height: 14,
                  width: 100,
                  color: Colors.grey.shade300,
                ),

                const SizedBox(height: 12),

                // Fake price row
                Row(
                  children: [
                    Container(
                      height: 16,
                      width: 60,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 14,
                      width: 40,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Fake category + rooms left
                Container(
                  height: 14,
                  width: 120,
                  color: Colors.grey.shade300,
                ),

                const SizedBox(height: 16),

                // Fake button
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 32,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // REAL CARD UI
  // ---------------------------------------------------------
  Widget _buildRealCard(BuildContext context) {
    final discount = deal!['discountPercent'];
    final finalPrice = deal!['finalPrice'];
    final basePrice = hotel!['basePrice'];
    final roomsLeft = deal!['availableRooms'];

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 6),
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: safeAssetImage(
                hotel?['imageUrls'] != null && hotel!['imageUrls'].isNotEmpty
                    ? hotel!['imageUrls'][0]
                    : '',
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Discount badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '-$discount%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Hotel name
                  Text(
                    hotel!['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  // Poetic subtitle
                  Text(
                    'Luxury stay in ${city!['name']}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Prices
                  Row(
                    children: [
                      Text(
                        '£$finalPrice',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '£$basePrice',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Category + rooms left
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        deal!['category'],
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      if (roomsLeft <= 5)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$roomsLeft rooms left!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Book Now button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/reservation/${deal!['id']}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Book Now'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
