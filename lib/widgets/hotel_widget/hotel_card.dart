import 'package:flutter/material.dart';

class HotelCard extends StatelessWidget {
  final Map<String, dynamic> hotel;
  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hotel image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              hotel['imageUrl'] ?? 'https://via.placeholder.com/300',
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hotel['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: List.generate(
                    hotel['stars'] ?? 0,
                    (index) =>
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                  ),
                ),
                Text('${hotel['basePrice']} £ / night'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
