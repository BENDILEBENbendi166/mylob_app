import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mylob_app/services/city_service.js' as CityService;
import 'package:mylob_app/services/hotel_service.js' as HotelService;
import 'package:mylob_app/utils/responsive.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_card.dart';

class HotelListScreen extends StatefulWidget {
  final String cityId;
  const HotelListScreen({super.key, required this.cityId});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  List<Map<String, dynamic>> hotels = [];
  List<Map<String, dynamic>> cities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final fetchedHotels = await HotelService.fetchHotelsByCity(widget.cityId);
    final fetchedCities = await CityService.fetchCitiesFirestore();

    setState(() {
      hotels = fetchedHotels;
      cities = fetchedCities;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    if (isLoading) {
      return GridView.builder(
        padding: r.pagePadding,
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

    if (hotels.isEmpty) {
      return const Center(child: Text("No hotels found"));
    }

    return GridView.builder(
      padding: r.pagePadding,
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
      itemCount: hotels.length,
      itemBuilder: (_, index) {
        final hotel = hotels[index];

        final city = cities.firstWhere(
          (c) => c['name'] == hotel['city'],
          orElse: () => {
            'id': 'unknown',
            'name': hotel['city'],
            'popularAttractions': [],
            'imageUrl': '',
          },
        );

        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.go('/hotel/${hotel['id']}'),
          child: HotelCard(
            hotel: hotel,
            city: city,
          ),
        );
      },
    );
  }
}
