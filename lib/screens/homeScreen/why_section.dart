import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:mylob_app/widgets/hotel_widget/build_info_card.dart';

class WhySection extends StatelessWidget {
  const WhySection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    // ✅ Decide how many columns based on screen size
    final columns = r.isDesktop
        ? 5
        : r.isTablet
            ? 3
            : 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing),
      child: Column(
        children: [
          Text(
            'Why Lobideyim.com?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          SizedBox(height: r.spacing),

          // ✅ Responsive grid instead of Wrap
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: columns,
            crossAxisSpacing: r.spacing,
            mainAxisSpacing: r.spacing,
            childAspectRatio: r.isDesktop ? 1.4 : 1.2,
            children: const [
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
        ],
      ),
    );
  }
}
