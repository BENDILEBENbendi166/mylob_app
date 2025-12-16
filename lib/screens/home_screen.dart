import 'package:flutter/material.dart';
import 'package:mylob_app/screens/hero_screen.dart';
import 'package:mylob_app/widgets/footer.dart';
import 'package:mylob_app/widgets/hotel_widget/build_info_card.dart';
import 'package:mylob_app/widgets/skeletons/carousel_skeleton.dart';
import 'package:mylob_app/widgets/skeletons/more_destination.dart';
import 'package:mylob_app/widgets/skeletons/now_playing_skeleton.dart';
// ignore: unused_import
import 'package:mylob_app/widgets/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final isWide = MediaQuery.of(context).size.width > 1100;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Hero banner
              const HeroScreen(),
              const SizedBox(height: 32),

              // Why Lobideyim section
              Text(
                '!Why MyLob.com?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 16),
              const Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  BuildInfoCard(
                    icon: Icons.credit_card,
                    title: 'Pay at hotel',
                    subtitle: 'No card needed',
                    color: Color.fromARGB(255, 26, 74, 129),
                  ),
                  BuildInfoCard(
                    icon: Icons.local_offer,
                    title: 'Real-time discounts',
                    subtitle: 'Up to 70% off',
                    color: Color.fromARGB(255, 26, 74, 129),
                  ),
                  BuildInfoCard(
                    icon: Icons.today,
                    title: 'Daily deals',
                    subtitle: 'City, family, beach',
                    color: Color.fromARGB(255, 26, 74, 129),
                  ),
                  BuildInfoCard(
                    icon: Icons.eco,
                    title: 'Zero waste',
                    subtitle: 'Fill empty rooms',
                    color: Color.fromARGB(255, 26, 74, 129),
                  ),
                  BuildInfoCard(
                    icon: Icons.support_agent,
                    title: '24/7 support',
                    subtitle: 'We\'re here to help',
                    color: Color.fromARGB(255, 26, 74, 129),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Deals section
              Text('Top Last-Minute Hotel Deals',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),

              Responsive.isDesktop(context)
                  ? const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(flex: 2, child: CarouselSkeleton()),
                        SizedBox(width: 20),
                        Flexible(flex: 1, child: NowPlayingSkeleton()),
                      ],
                    )
                  : const Column(
                      children: [
                        CarouselSkeleton(),
                        SizedBox(height: 20),
                        NowPlayingSkeleton(),
                      ],
                    ),

              const SizedBox(height: 40),

              // Explore section
              Text(
                'Explore More Destinations',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 20),
              const MoreDestinationSkeleton(),

              const SizedBox(height: 40),

              // Footer
              const FooterScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
