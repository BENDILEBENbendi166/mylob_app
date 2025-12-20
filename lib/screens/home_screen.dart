import 'package:flutter/material.dart';
import 'package:mylob_app/screens/hero_screen.dart';
import 'package:mylob_app/widgets/drawer.dart';
import 'package:mylob_app/widgets/footer.dart';
import 'package:mylob_app/widgets/hotel_widget/build_info_card.dart';
import 'package:mylob_app/widgets/city_widget/city_card.dart';
import 'package:mylob_app/widgets/navbar.dart';
import 'package:mylob_app/widgets/skeletons/hotel_carousel.dart';
import 'package:mylob_app/widgets/skeletons/more_destination.dart';
import 'package:mylob_app/widgets/skeletons/now_playing_skeleton.dart';
import 'package:mylob_app/services/hotel_service.dart';
import 'package:mylob_app/services/deal_service.dart';
import 'package:mylob_app/services/city_service.dart';
import 'package:mylob_app/seed/database_seeder.dart';
import 'package:flutter/foundation.dart'; // for kDebugMode

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
    final fetchedDeals = await DealService.fetchDealsByHotel('hotelId');
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
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 1100;
    final isTablet = width > 700 && width <= 1100;

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomNavBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // ✅ Full-width hero banner
            const HeroScreen(),
            const SizedBox(height: 48),

            // ✅ Why section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Why Lobideyim.com?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 20),
                  const Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      BuildInfoCard(
                        icon: Icons.credit_card,
                        title: 'Pay at hotel',
                        subtitle: 'No card needed',
                        color: Color.fromARGB(255, 26, 74, 129),
                      ),
                      BuildInfoCard(
                        icon: Icons.local_offer,
                        title: 'Real-time discounts',
                        subtitle: 'Up to 70% off',
                        color: Color.fromARGB(255, 26, 74, 129),
                      ),
                      BuildInfoCard(
                        icon: Icons.today,
                        title: 'Daily deals',
                        subtitle: 'City, family, beach',
                        color: Color.fromARGB(255, 26, 74, 129),
                      ),
                      BuildInfoCard(
                        icon: Icons.eco,
                        title: 'Zero waste',
                        subtitle: 'Fill empty rooms',
                        color: Color.fromARGB(255, 26, 74, 129),
                      ),
                      BuildInfoCard(
                        icon: Icons.support_agent,
                        title: '24/7 support',
                        subtitle: 'We\'re here to help',
                        color: Color.fromARGB(255, 26, 74, 129),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // ✅ Deals section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top Last-Minute Hotel Deals',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: HotelCarousel(
                                hotels: hotels,
                                isLoading: isLoading,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              flex: 1,
                              child: isLoading
                                  ? const NowPlayingSkeleton()
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: deals.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 12),
                                          child: Text(
                                            deals[index]['title'],
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            HotelCarousel(
                              hotels: hotels,
                              isLoading: isLoading,
                            ),
                            const SizedBox(height: 24),
                            isLoading
                                ? const NowPlayingSkeleton()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: deals.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: Text(
                                          deals[index]['title'],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // ✅ Explore section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Explore More Destinations',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 24),
                  isLoading
                      ? const MoreDestinationSkeleton()
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isWide
                                ? 4
                                : isTablet
                                    ? 3
                                    : 2,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: cities.length,
                          itemBuilder: (context, index) =>
                              CityCard(city: cities[index]),
                        ),
                ],
              ),
            ),

            const SizedBox(height: 60),

// ✅ Developer-only seed button
            if (kDebugMode)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await DatabaseSeeder.seedAll();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("✅ Database seeded successfully!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("❌ Seeding failed: $e"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    print("Seeding cities...");
                    print("Seeding hotels...");
                    print("Seeding deals...");
                  },
                  child: const Text("Seed Database"),
                ),
              ),
            // ✅ Footer
            const FooterScreen(),
          ],
        ),
      ),
    );
  }
}
