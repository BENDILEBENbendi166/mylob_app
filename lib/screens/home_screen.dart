import 'package:flutter/material.dart';
import 'package:mylob_app/screens/hero_screen.dart';
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
    final isWide = MediaQuery.of(context).size.width > 1100;

    return Scaffold(
      appBar: const CustomNavBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Hero banner
              const HeroScreen(),
              const SizedBox(height: 32),

              // Why section
              Text(
                'Why MyLob.com?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 16),
              const Wrap(
                spacing: 16,
                runSpacing: 16,
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

              const SizedBox(height: 40),

              // Deals section
              Text('Top Last-Minute Hotel Deals',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),

              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          child: HotelCarousel(
                            hotels: hotels,
                            isLoading: isLoading,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          flex: 1,
                          child: isLoading
                              ? const NowPlayingSkeleton()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: deals.length,
                                  itemBuilder: (context, index) {
                                    return Text(deals[index]['title']);
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
                        const SizedBox(height: 20),
                        isLoading
                            ? const NowPlayingSkeleton()
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: deals.length,
                                itemBuilder: (context, index) {
                                  return Text(deals[index]['title']);
                                },
                              ),
                      ],
                    ),

              const SizedBox(height: 40),

              // Explore section
              Text(
                'Explore More Destinations',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const MoreDestinationSkeleton()
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: cities.length,
                      itemBuilder: (context, index) =>
                          CityCard(city: cities[index]),
                    ),

              const SizedBox(height: 40),

              // Footer
              const FooterScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
