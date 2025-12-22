import 'package:flutter/material.dart';
import 'package:mylob_app/services/city_service.js' as CityService;
import 'package:mylob_app/widgets/city_widget/city_card.dart';
import 'package:mylob_app/utils/responsive.dart';

class CityListScreen extends StatefulWidget {
  const CityListScreen({super.key});

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  List<Map<String, dynamic>> cities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCities();
  }

  Future<void> _fetchCities() async {
    final result = await CityService.fetchCitiesFirestore();

    setState(() {
      cities = result;
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
          crossAxisCount: r.gridColumns,
          childAspectRatio: r.isDesktop
              ? 1
              : r.isTablet
                  ? 0.9
                  : 0.8,
          crossAxisSpacing: r.spacing / 2,
          mainAxisSpacing: r.spacing / 2,
        ),
        itemCount: 6,
        itemBuilder: (_, __) => const CityCard.skeleton(),
      );
    }

    if (cities.isEmpty) {
      return const Center(
        child: Text(
          'No cities available',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }

    return GridView.builder(
      padding: r.pagePadding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: r.gridColumns,
        childAspectRatio: r.isDesktop
            ? 1
            : r.isTablet
                ? 0.9
                : 0.8,
        crossAxisSpacing: r.spacing / 2,
        mainAxisSpacing: r.spacing / 2,
      ),
      itemCount: cities.length,
      itemBuilder: (_, index) => CityCard(city: cities[index]),
    );
  }
}
