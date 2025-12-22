import 'package:flutter/material.dart';
import 'package:mylob_app/screens/homeScreen/Explore_Button.dart';
import 'package:mylob_app/screens/homeScreen/hero_screen.dart';
import 'package:mylob_app/screens/homeScreen/deals_section.dart';
import 'package:mylob_app/screens/homeScreen/seed_button.dart';
import 'package:mylob_app/screens/homeScreen/why_section.dart';
import 'package:mylob_app/screens/homeScreen/footer.dart';
import 'package:mylob_app/services/city_service.dart';
import 'package:mylob_app/services/deal_service.dart';
import 'package:mylob_app/services/hotel_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> hotels = [];
  List<Map<String, dynamic>> deals = [];
  List<Map<String, dynamic>> cities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final fetchedHotels = await HotelService.fetchHotels();
    final fetchedDeals = await DealService.fetchDealsByHotel('HotelId');
    final fetchedCities = await CityService.fetchCitiesFirestore();

    setState(() {
      hotels = fetchedHotels;
      deals = fetchedDeals;
      cities = fetchedCities;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const HeroScreen(),
            const SizedBox(height: 48),

            const WhySection(),
            const SizedBox(height: 60),

            // ✅ FIXED: pass cities
            HomeDealsSection(
              hotels: hotels,
              cities: cities,
              deals: deals,
              isLoading: isLoading,
            ),

            const SizedBox(height: 60),

            const SeedButton(),
            const SizedBox(height: 60),

            const ExploreButton(),
            const SizedBox(height: 60),

            const FooterScreen(),
          ],
        ),
      ),
    );
  }
}
