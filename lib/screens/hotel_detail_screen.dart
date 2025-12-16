import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/hotel_widget/deal_card.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_info_widget.dart';

class HotelDetailScreen extends StatelessWidget {
  final String hotelId;
  const HotelDetailScreen({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch hotel + deals from Firestore
    final hotel = {};
    final deals = [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          HotelInfoWidget(hotel: hotel[hotel]),
          const SizedBox(height: 20),
          ...deals.map((deal) => DealCard(deal: deal)),
        ],
      ),
    );
  }
}
