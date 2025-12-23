import 'package:flutter/material.dart';
import 'package:mylob_app/services/deal_service.dart';
import 'package:mylob_app/services/hotel_service.dart';
import 'package:mylob_app/services/city_service.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:mylob_app/screens/deal/widgets/deal_hero.dart';
import 'package:mylob_app/screens/deal/widgets/deal_info.dart';
import 'package:mylob_app/screens/deal/widgets/book_button.dart';

class DealScreen extends StatefulWidget {
  final String dealId;
  const DealScreen({super.key, required this.dealId});

  @override
  State<DealScreen> createState() => _DealScreenState();
}

class _DealScreenState extends State<DealScreen> {
  Map<String, dynamic>? deal;
  Map<String, dynamic>? hotel;
  Map<String, dynamic>? city;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Fetch deal data
      final fetchedDeal = await DealService.fetchDealById(widget.dealId);
      
      if (!mounted) return;

      // Fetch hotel data if deal has hotelId
      Map<String, dynamic>? fetchedHotel;
      if (fetchedDeal != null && fetchedDeal['hotelId'] != null) {
        fetchedHotel = await HotelService.fetchHotelById(fetchedDeal['hotelId']);
      }

      if (!mounted) return;

      // Fetch city data if hotel has city name
      Map<String, dynamic>? fetchedCity;
      if (fetchedHotel != null && fetchedHotel['city'] != null) {
        final cities = await CityService.fetchCitiesFirestore();
        try {
          fetchedCity = cities.firstWhere(
            (c) => c['name'] == fetchedHotel!['city'],
          );
        } catch (e) {
          // City not found, leave as null
          fetchedCity = null;
        }
      }

      if (!mounted) return;

      setState(() {
        deal = fetchedDeal;
        hotel = fetchedHotel;
        city = fetchedCity;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching deal data: $e');
    }
  }

  void _handleBooking() {
    // This would navigate to a reservation/checkout screen
    // For now, the BookButton widget handles showing a confirmation dialog
    debugPrint('Booking deal: ${widget.dealId}');
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Deal'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. DealHero - Hotel image with discount
                  DealHero(
                    hotel: hotel,
                    deal: deal,
                    isLoading: isLoading,
                  ),
                  
                  SizedBox(height: r.spacing * 2),

                  // 2. DealInfo - Price breakdown and details
                  DealInfo(
                    deal: deal,
                    hotel: hotel,
                    city: city,
                    isLoading: isLoading,
                  ),
                  
                  SizedBox(height: r.spacing * 2),
                ],
              ),
            ),
          ),

          // 3. BookButton - Fixed at bottom
          BookButton(
            deal: deal,
            hotel: hotel,
            isLoading: isLoading,
            onPressed: _handleBooking,
          ),
        ],
      ),
    );
  }
}
