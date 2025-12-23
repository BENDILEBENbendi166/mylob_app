import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';

class HeroText extends StatelessWidget {
  final Responsive r;
  final String? cityName;
  
  const HeroText({
    super.key,
    required this.r,
    this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    final String tagline = cityName != null 
        ? 'Discover $cityName'
        : 'Catch last-minute room deals!';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tagline,
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontWeight: FontWeight.w600,
            fontSize: r.isDesktop
                ? 24
                : r.isTablet
                    ? 20
                    : 18,
          ),
        ),
        SizedBox(height: r.spacing / 4),
        Text(
          'Up to 70% off after 18:00 — Pay at hotel',
          style: TextStyle(
            color: Colors.white,
            fontSize: r.isDesktop
                ? 36
                : r.isTablet
                    ? 28
                    : 24,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
