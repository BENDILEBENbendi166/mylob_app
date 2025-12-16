import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/city_widget/city_card.dart';

class CityListScreen extends StatelessWidget {
  const CityListScreen({super.key});

  get responsive => null;

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch cities from Firestore
    final cities = [];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: responsive.isMobile(context)
            ? 2
            : responsive.isTablet(context)
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
