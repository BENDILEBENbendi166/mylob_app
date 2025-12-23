import 'package:flutter/material.dart';
import 'package:mylob_app/screens/homeScreen/Explore_Button.dart';
import 'package:mylob_app/screens/homeScreen/drawer.dart';
import 'package:mylob_app/screens/homeScreen/hero_screen.dart';
import 'package:mylob_app/screens/homeScreen/deals_section.dart';
import 'package:mylob_app/screens/homeScreen/navbar.dart';
import 'package:mylob_app/screens/homeScreen/why_section.dart';
import 'package:mylob_app/screens/homeScreen/footer.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final fetchedHotels = await HotelService.fetchHotels();
    final fetchedDeals = await DealService.fetchAllDeals();
    final fetchedCities = await CityService.fetchCitiesFirestore();

    if (!mounted) return; // ✅ prevents setState after dispose

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
      appBar: const CustomNavBar(
        backgroundColor: kBackgroundColor,
        iconColor: kIconColor,
      ),
      drawer: const CustomDrawer(),
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

            const ExploreButton(),
            const SizedBox(height: 60),

            const FooterScreen(),
          ],
        ),
      ),
    );
  }
}
