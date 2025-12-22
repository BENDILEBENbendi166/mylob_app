import 'package:flutter/material.dart';
import 'package:mylob_app/services/deal_service.js' as DealService;
import 'package:mylob_app/services/hotel_service.dart';
import 'package:mylob_app/widgets/hotel_widget/deal_card.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_info_widget.dart';

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
    final fetchedHotel = await HotelService.fetchHotelById(widget.hotelId);
    final fetchedDeals = await DealService.fetchDealsByHotel(widget.hotelId);

    if (!mounted) return;

    setState(() {
      hotel = fetchedHotel;
      deals = fetchedDeals;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 20,
              width: 150,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            ),
            SizedBox(height: 12),
            DealCard.skeleton(),
            SizedBox(height: 12),
            DealCard.skeleton(),
          ],
        ),
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
          if (hotel!['photoUrls'] != null && hotel!['photoUrls'].isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/${hotel!['photoUrls'][0]}',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 20),
          HotelInfoWidget(hotel: hotel!),
          const SizedBox(height: 32),
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
                  children: deals
                      .map((deal) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: DealCard(deal: deal),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}
