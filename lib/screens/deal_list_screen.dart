import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/hotel_widget/deal_card.dart';
import 'package:mylob_app/widgets/skeletons/now_playing_skeleton.dart';
import 'package:mylob_app/services/deal_service.dart';

class DealListScreen extends StatefulWidget {
  final String hotelId;
  const DealListScreen({super.key, required this.hotelId});

  @override
  State<DealListScreen> createState() => _DealListScreenState();
}

class _DealListScreenState extends State<DealListScreen> {
  List<Map<String, dynamic>> deals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDeals();
  }

  Future<void> _fetchDeals() async {
    final result = await DealService.fetchDealsByHotel(widget.hotelId);
    setState(() {
      deals = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: NowPlayingSkeleton(itemCount: 5), // shimmer list
      );
    }

    if (deals.isEmpty) {
      return const Center(
        child: Text(
          'No deals available for this hotel',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }

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
