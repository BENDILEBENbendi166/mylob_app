import 'package:flutter/material.dart';
import 'package:mylob_app/widgets/skeletons/carousel_skeleton.dart';

class HeroScreen extends StatefulWidget {
  const HeroScreen({super.key});

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  Null get index => null;

  @override
  Widget build(BuildContext context) {
    final _ = MediaQuery.of(context).size.width > 1100;

    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image.asset('assets/images/c_2.jpg', fit: BoxFit.cover),

          const CarouselSkeleton(),
          Container(color: const Color.fromARGB(184, 0, 0, 0).withOpacity(0.4)),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Catch last-minute room deals!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 223, 231, 238),
                    fontWeight: FontWeight.bold,
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
                SizedBox(height: 16),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      side: BorderSide.none),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for hotels...',
                      suffixIcon: Icon(Icons.search),
                      suffixStyle: TextStyle(
                        color: Color.fromARGB(255, 223, 231, 238),
                      ),
                      suffixIconColor: Color.fromARGB(255, 5, 36, 64),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
