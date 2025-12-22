import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';

class HeroText extends StatelessWidget {
  final Responsive r;
  const HeroText({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catch last-minute room deals!',
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
