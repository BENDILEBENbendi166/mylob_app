import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_card.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryId;
  const CategoryScreen({super.key, required this.categoryId});
  
  get responsive => null;

  @override
  Widget build(BuildContext context) {
    final hotels = []; // placeholder

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: responsive.isMobile(context)
            ? 1
            : responsive.isTablet(context)
                ? 2
                : 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: hotels.length,
      itemBuilder: (context, index) => HotelCard(hotel: hotels[index]),
    );
  }
}
