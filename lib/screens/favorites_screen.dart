import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_card.dart';
import 'package:mylob_app/widgets/skeletons/more_destination.dart';
import 'package:mylob_app/services/hotel_service.dart';
import 'package:mylob_app/widgets/responsive.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    // TODO: Replace with Firestore/local storage logic
    final result = await HotelService.fetchHotels(); // placeholder
    setState(() {
      favorites = result.take(5).toList(); // simulate favorites
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Favorites')),
      body: isLoading
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: MoreDestinationSkeleton(),
            )
          : favorites.isEmpty
              ? const Center(child: Text('No favorites yet'))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isMobile(context)
                        ? 1
                        : Responsive.isTablet(context)
                            ? 2
                            : 3,
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
