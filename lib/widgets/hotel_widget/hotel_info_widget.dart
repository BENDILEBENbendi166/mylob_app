import 'package:flutter/material.dart';

class HotelInfoWidget extends StatelessWidget {
  final Map<String, dynamic> hotel;
  const HotelInfoWidget({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final features = hotel['features'] as List<dynamic>? ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hotel['name'],
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          "${hotel['city']} • ${hotel['district']}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        Text(
          "⭐ ${hotel['stars']} stars",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 12),
        Text(
          "£${hotel['basePrice']} per night",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Text(
          "Features",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: features.map((f) => Chip(label: Text(f))).toList(),
        ),
      ],
    );
  }
}
