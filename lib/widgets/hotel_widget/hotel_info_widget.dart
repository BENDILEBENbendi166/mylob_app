import 'package:flutter/material.dart';

class HotelInfoWidget extends StatelessWidget {
  final Map<String, dynamic> hotel;
  const HotelInfoWidget({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hotel['name'], style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(hotel['address'] ?? 'No address available'),
        const SizedBox(height: 12),
        Text(hotel['description'] ?? 'No description available'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: (hotel['amenities'] as List<dynamic>? ?? [])
              .map((a) => Chip(label: Text(a)))
              .toList(),
        ),
      ],
    );
  }
}
