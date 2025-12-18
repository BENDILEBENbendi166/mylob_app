import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/hotel_widget/deal_card.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_info_widget.dart';
import 'package:mylob_app/widgets/skeletons/now_playing_skeleton.dart';
import 'package:mylob_app/services/hotel_service.dart';
import 'package:mylob_app/services/deal_service.dart';

class HotelDetailScreen extends StatefulWidget {
  final String hotelId;
  const HotelDetailScreen({super.key, required this.hotelId});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  Map<String, dynamic>? hotel;
  List<Map<String, dynamic>> deals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final fetchedHotel = await HotelService.fetchHotelsByCity(widget.hotelId);
    final fetchedDeals = await DealService.fetchDealsByHotel(widget.hotelId);

    setState(() {
      hotel = fetchedHotel as Map<String, dynamic>?;
      deals = fetchedDeals;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: NowPlayingSkeleton(itemCount: 3), // shimmer list
      );
    }

    if (hotel == null) {
      return const Center(
        child: Text(
          'Hotel not found',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HotelInfoWidget(hotel: hotel!), // ✅ pass hotel map directly
          const SizedBox(height: 20),
          Text(
            'Available Deals',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          deals.isEmpty
              ? const Text('No deals available for this hotel')
              : Column(
                  children: deals.map((deal) => DealCard(deal: deal)).toList(),
                ),
        ],
      ),
    );
  }
}
