import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/skeletons/carousel_skeleton.dart';

class HeroScreen extends StatefulWidget {
  const HeroScreen({super.key});

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  double _heroHeight(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    // ✅ Adaptive hero height for all screens
    if (h < 600) return 260; // small mobile
    if (h < 900) return 320; // large mobile / tablet
    return 380; // desktop / web
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final heroHeight = _heroHeight(context);

    return SizedBox(
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Background carousel (skeleton for now)
          const CarouselSkeleton(),

          // ✅ Cinematic gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.55),
                  Colors.black.withOpacity(0.25),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // ✅ Foreground content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: isWide
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _buildHeroText(isWide)),
                      const SizedBox(width: 40),
                      SizedBox(width: 350, child: _buildSearchBar()),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroText(isWide),
                      const SizedBox(height: 20),
                      _buildSearchBar(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroText(bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catch last-minute room deals!',
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontWeight: FontWeight.w600,
            fontSize: isWide ? 22 : 18,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Up to 70% off after 18:00 — Pay at hotel',
          style: TextStyle(
            color: Colors.white,
            fontSize: isWide ? 32 : 24,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onSubmitted: (query) {
          print("Search submitted: $query");
        },
        decoration: const InputDecoration(
          hintText: 'Search for hotels...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
