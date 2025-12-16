import 'package:flutter/material.dart';


class DealCard extends StatelessWidget {
  final Map<String, dynamic> deal;
  const DealCard({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange[50],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.local_offer, color: Colors.orange),
        title: Text(deal['title'] ?? 'Special Deal'),
        subtitle: Text('Expires: ${deal['expiry'] ?? 'N/A'}'),
        trailing: Text(
          '${deal['discount']}% OFF',
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
