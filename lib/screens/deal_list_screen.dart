import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/hotel_widget/deal_card.dart';
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

  StreamSubscription? _dealSub;

  @override
  void initState() {
    super.initState();
    _listenToDeals();
  }

  void _listenToDeals() {
    _dealSub = DealService.streamDeals(widget.hotelId).listen((dealList) {
      if (!mounted) return;
      setState(() {
        deals = dealList;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _dealSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => const DealCard.skeleton(),
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
