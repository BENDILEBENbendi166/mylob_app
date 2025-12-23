import 'package:flutter/material.dart';
import 'package:mylob_app/screens/homeScreen/hero_search_bar.dart';
import 'package:mylob_app/screens/homeScreen/hero_text.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:mylob_app/utils/image_path.dart';

class HeroScreen extends StatelessWidget {
  final Map<String, dynamic>? featuredCity;
  final bool isLoading;

  const HeroScreen({
    super.key,
    this.featuredCity,
    this.isLoading = false,
  });

  double _heroHeight(Responsive r) {
    if (r.isMobile) return 320;
    if (r.isTablet) return 380;
    return 460;
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final heroHeight = _heroHeight(r);

    return SizedBox(
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Background image - use featured city image if available
          _buildBackgroundImage(),

          // ✅ Crushy blue gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF1E88E5).withOpacity(0.7), // Blue
                  const Color(0xFF1565C0).withOpacity(0.5), // Dark blue
                  const Color(0xFF42A5F5).withOpacity(0.3), // Light blue
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // ✅ Foreground content only
          Padding(
            padding: EdgeInsets.only(
              top: r.spacing * 6,
              left: r.spacing,
              right: r.spacing,
              bottom: r.spacing,
            ),
            child: r.isDesktop
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child:
                              HeroText(r: r, cityName: featuredCity?['name'])),
                      SizedBox(width: r.spacing * 2),
                      const SizedBox(width: 350, child: HeroSearchBar()),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeroText(r: r, cityName: featuredCity?['name']),
                      SizedBox(height: r.spacing),
                      const HeroSearchBar(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    if (isLoading) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade100,
              Colors.blue.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );
    }

    // Always use default hero.jpg for consistent branding
    return Image.asset(
      'assets/images/hero.jpg',
      fit: BoxFit.cover,
      alignment: Alignment.center,
      errorBuilder: (context, error, stackTrace) {
        // Fallback with nice gradient background if image fails
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF1E88E5),
                const Color(0xFF1565C0),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }
}
