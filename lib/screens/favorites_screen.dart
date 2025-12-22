import 'package:flutter/material.dart';
import 'package:mylob_app/services/city_service.dart';
import 'package:mylob_app/services/hotel_service.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_card.dart';
import 'package:mylob_app/utils/responsive.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> favorites = [];
  List<Map<String, dynamic>> cities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final allHotels = await HotelService.fetchHotels();
    // ignore: unused_local_variable
    final allCities = await CityService.fetchCitiesFirestore();

    // ✅ Simulate favorites (first 5)
    final favs = allHotels.take(5).toList();

    setState(() {
      favorites = favs;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Favorites')),
      body: Padding(
        padding: r.pagePadding,
        child: isLoading
            ? _buildSkeletonGrid(r)
            : favorites.isEmpty
                ? const Center(
                    child: Text(
                      'No favorites yet',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : _buildFavoritesGrid(r),
      ),
    );
  }

  Widget _buildSkeletonGrid(Responsive r) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: r.isMobile
            ? 1
            : r.isTablet
                ? 2
                : 3,
        childAspectRatio: r.isDesktop
            ? 1
            : r.isTablet
                ? 0.9
                : 0.8,
        crossAxisSpacing: r.spacing / 2,
        mainAxisSpacing: r.spacing / 2,
      ),
      itemCount: 6,
      itemBuilder: (_, __) => const HotelCard.skeleton(),
    );
  }

  Widget _buildFavoritesGrid(Responsive r) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: r.isMobile
            ? 1
            : r.isTablet
                ? 2
                : 3,
        childAspectRatio: r.isDesktop
            ? 1
            : r.isTablet
                ? 0.9
                : 0.8,
        crossAxisSpacing: r.spacing / 2,
        mainAxisSpacing: r.spacing / 2,
      ),
      itemCount: favorites.length,
      itemBuilder: (_, index) {
        final hotel = favorites[index];

        // ✅ Find matching city
        final city = cities.firstWhere(
          (c) => c['name'] == hotel['city'],
          orElse: () => {
            'id': 'unknown',
            'name': hotel['city'],
            'popularAttractions': [],
            'imageUrl': '',
          },
        );

        return HotelCard(
          hotel: hotel,
          city: city,
        );
      },
    );
  }
}
