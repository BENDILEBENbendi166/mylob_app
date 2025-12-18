import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/city_widget/city_card.dart';
import 'package:mylob_app/widgets/skeletons/more_destination.dart';
import 'package:mylob_app/services/city_service.dart';
import 'package:mylob_app/widgets/responsive.dart';

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
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: MoreDestinationSkeleton(), // shimmer grid
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
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context)
            ? 2
            : Responsive.isTablet(context)
                ? 3
                : 4,
        childAspectRatio: 0.9,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: cities.length,
      itemBuilder: (context, index) => CityCard(city: cities[index]),
    );
  }
}
