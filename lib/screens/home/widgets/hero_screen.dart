import 'package:flutter/material.dart';

class HeroScreen extends StatelessWidget {
  final String imageUrl;
  final String tagline;

  const HeroScreen({required this.imageUrl, required this.tagline, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(imageUrl,
            fit: BoxFit.cover, width: double.infinity, height: 200),
        Positioned(
          bottom: 16,
          left: 16,
          child: Text(
            tagline,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                    color: Colors.black54, offset: Offset(0, 2), blurRadius: 6),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
