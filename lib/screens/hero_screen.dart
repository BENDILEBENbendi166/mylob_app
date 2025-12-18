import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/skeletons/carousel_skeleton.dart';
// import 'package:mylob_app/widgets/skeletons/custom_carousel_slider.dart';

class HeroScreen extends StatefulWidget {
  const HeroScreen({super.key});

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 1100;

    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // TODO: Replace with CustomCarouselSlider once images are ready
          const CarouselSkeleton(),

          // Overlay gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: isWide
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildHeroText(),
                      _buildSearchBar(),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroText(),
                      const SizedBox(height: 16),
                      _buildSearchBar(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catch last-minute room deals!',
          style: TextStyle(
            color: Color.fromARGB(255, 223, 231, 238),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          'Up to 70% off after 18:00 — Pay at hotel',
          style: TextStyle(
            color: Color.fromARGB(255, 223, 231, 238),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Card(
      elevation: 6,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: TextField(
        onSubmitted: (query) {
          // TODO: Navigate to search results screen
          print("Search submitted: $query");
        },
        decoration: const InputDecoration(
          hintText: 'Search for hotels...',
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}
