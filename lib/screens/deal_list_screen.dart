import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/hotel_widget/deal_card.dart';

class DealListScreen extends StatelessWidget {
  final String hotelId;
  const DealListScreen({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch deals from Firestore
    final deals = [];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: deals.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return DealCard(deal: deals[index]);
      },
    );
  }
}
