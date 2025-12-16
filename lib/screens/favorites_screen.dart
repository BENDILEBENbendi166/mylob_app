import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch favorites from Firestore or local storage
    final favorites = [];

    return Scaffold(
      appBar: AppBar(title: const Text('My Favorites')),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return HotelCard(hotel: favorites[index]);
              },
            ),
    );
  }
}
