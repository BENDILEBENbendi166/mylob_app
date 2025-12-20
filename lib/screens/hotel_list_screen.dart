import 'package:flutter/material.dart';
import 'package:mylob_app/services/hotel_service.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_card.dart';
import 'package:mylob_app/widgets/skeletons/now_playing_skeleton.dart';
import 'hotel_detail_screen.dart';

class HotelListScreen extends StatefulWidget {
  final String cityId;
  const HotelListScreen({super.key, required this.cityId});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  List<Map<String, dynamic>> hotels = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHotels();
  }

  Future<void> _fetchHotels() async {
    final fetched = await HotelService.fetchHotelsByCity(widget.cityId);

    setState(() {
      hotels = fetched;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: NowPlayingSkeleton(itemCount: 5),
      );
    }

    if (hotels.isEmpty) {
      return const Center(
        child: Text("No hotels found"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: hotels.length,
      itemBuilder: (context, index) {
        final hotel = hotels[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HotelDetailScreen(hotelId: hotel['id']),
              ),
            );
          },
          child: HotelCard(hotel: hotel),
        );
      },
    );
  }
}
