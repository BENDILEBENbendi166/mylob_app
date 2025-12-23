import 'package:flutter/material.dart';
import 'package:mylob_app/services/hotel_service.dart';
import 'package:mylob_app/services/deal_service.dart';
import 'package:mylob_app/services/city_service.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:mylob_app/screens/hotel/widgets/hotel_hero.dart';
import 'package:mylob_app/screens/hotel/widgets/hotel_info.dart';
import 'package:mylob_app/screens/hotel/widgets/deals_list.dart';

class HotelScreen extends StatefulWidget {
  final String hotelId;
  const HotelScreen({super.key, required this.hotelId});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  Map<String, dynamic>? hotel;
  Map<String, dynamic>? city;
  List<Map<String, dynamic>> deals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Fetch hotel data
      final fetchedHotel = await HotelService.fetchHotelById(widget.hotelId);
      
      if (!mounted) return;

      // Fetch deals for this hotel
      final fetchedDeals = await DealService.fetchDealsByHotel(widget.hotelId);

      if (!mounted) return;

      // Fetch city data if hotel has city name
      Map<String, dynamic>? fetchedCity;
      if (fetchedHotel != null && fetchedHotel['city'] != null) {
        // Get all cities and find the matching one
        final cities = await CityService.fetchCitiesFirestore();
        try {
          fetchedCity = cities.firstWhere(
            (c) => c['name'] == fetchedHotel['city'],
          );
        } catch (e) {
          // City not found, leave fetchedCity as null
          fetchedCity = null;
        }
      }

      if (!mounted) return;

      setState(() {
        hotel = fetchedHotel;
        deals = fetchedDeals;
        city = fetchedCity;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching hotel data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(hotel?['name'] ?? 'Hotel Details'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HotelHero - Carousel or single image
            HotelHero(
              hotel: hotel,
              isLoading: isLoading,
            ),
            
            SizedBox(height: r.spacing * 2),

            // 2. HotelInfo - Hotel details
            HotelInfo(
              hotel: hotel,
              city: city,
              isLoading: isLoading,
            ),
            
            SizedBox(height: r.spacing * 2),

            // 3. DealsList - Available deals
            DealsList(
              deals: deals,
              isLoading: isLoading,
            ),
            
            SizedBox(height: r.spacing * 2),
          ],
        ),
      ),
    );
  }
}
