import 'package:flutter/material.dart';
import 'package:mylob_app/screens/homeScreen/Explore_Button.dart';
import 'package:mylob_app/screens/homeScreen/drawer.dart';
import 'package:mylob_app/screens/homeScreen/hero_screen.dart';
import 'package:mylob_app/screens/homeScreen/deals_section.dart';
import 'package:mylob_app/screens/homeScreen/navbar.dart';
import 'package:mylob_app/screens/homeScreen/why_section.dart';
import 'package:mylob_app/screens/homeScreen/footer.dart';
import 'package:mylob_app/screens/homeScreen/city_spotlight_carousel.dart';
import 'package:mylob_app/screens/homeScreen/deal_of_the_day.dart';
import 'package:mylob_app/screens/homeScreen/last_minute_deals_section.dart';
import 'package:mylob_app/screens/homeScreen/recommended_hotels_section.dart';
import 'package:mylob_app/services/city_service.dart';
import 'package:mylob_app/services/deal_service.dart';
import 'package:mylob_app/services/hotel_service.dart';

const Color kBackgroundColor = Color.fromARGB(255, 26, 74, 129);
const Color kIconColor = Colors.white;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> hotels = [];
  List<Map<String, dynamic>> deals = [];
  List<Map<String, dynamic>> cities = [];
  Map<String, dynamic>? featuredCity;
  Map<String, dynamic>? topDeal;
  Map<String, dynamic>? topDealHotel;
  List<Map<String, dynamic>> lastMinuteDeals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final fetchedHotels = await HotelService.fetchHotels();
      final fetchedDeals = await DealService.fetchAllDeals();
      final fetchedCities = await CityService.fetchCitiesFirestore();

      if (!mounted) return; // ✅ prevents setState after dispose

      // Process data
      final processedFeaturedCity = fetchedCities.isNotEmpty ? fetchedCities.first : null;
      
      // Get top deal (highest discount percentage)
      Map<String, dynamic>? processedTopDeal;
      Map<String, dynamic>? processedTopDealHotel;
      if (fetchedDeals.isNotEmpty) {
        processedTopDeal = fetchedDeals.reduce((curr, next) {
          final currDiscount = curr['discountPercent'] ?? 0;
          final nextDiscount = next['discountPercent'] ?? 0;
          return currDiscount > nextDiscount ? curr : next;
        });
        
        // Fetch hotel for the top deal
        if (processedTopDeal['hotelId'] != null) {
          processedTopDealHotel = await HotelService.fetchHotelById(processedTopDeal['hotelId']);
        }
      }

      // Filter last minute deals (activeAfter18 == true)
      final processedLastMinuteDeals = fetchedDeals
          .where((deal) => deal['activeAfter18'] == true)
          .toList();

      setState(() {
        hotels = fetchedHotels;
        deals = fetchedDeals;
        cities = fetchedCities;
        featuredCity = processedFeaturedCity;
        topDeal = processedTopDeal;
        topDealHotel = processedTopDealHotel;
        lastMinuteDeals = processedLastMinuteDeals;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      // Handle error gracefully - data will show as empty
      debugPrint('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar(
        backgroundColor: kBackgroundColor,
        iconColor: kIconColor,
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // 1. HeroScreen - Dynamic with featured city
            HeroScreen(
              featuredCity: featuredCity,
              isLoading: isLoading,
            ),
            const SizedBox(height: 48),

            // 2. CitySpotlightCarousel - Horizontal carousel of cities
            CitySpotlightCarousel(
              cities: cities,
              isLoading: isLoading,
            ),
            const SizedBox(height: 48),

            // 3. DealOfTheDay - Highlight best deal
            DealOfTheDay(
              topDeal: topDeal,
              hotel: topDealHotel,
              isLoading: isLoading,
            ),
            const SizedBox(height: 48),

            // 4. LastMinuteDealsSection - List of urgent deals
            LastMinuteDealsSection(
              lastMinuteDeals: lastMinuteDeals,
              isLoading: isLoading,
            ),
            const SizedBox(height: 48),

            const WhySection(),
            const SizedBox(height: 60),

            // 5. RecommendedHotelsSection - Top-rated hotels
            RecommendedHotelsSection(
              hotels: hotels,
              cities: cities,
              isLoading: isLoading,
            ),
            const SizedBox(height: 48),

            // Original HomeDealsSection - kept for backward compatibility
            HomeDealsSection(
              hotels: hotels,
              cities: cities,
              deals: deals,
              isLoading: isLoading,
            ),

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
