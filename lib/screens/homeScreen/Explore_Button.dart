import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class ExploreButton extends StatelessWidget {
  const ExploreButton({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.spacing * 2),
      child: Center(
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => context.go('/cities'),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(
              horizontal: r.isDesktop ? 40 : 28,
              vertical: r.isDesktop ? 18 : 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade600,
                  Colors.blue.shade400,
                  Colors.blue.shade300,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.4),
                  blurRadius: 18,
                  spreadRadius: 1,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              'Explore All Cities',
              style: TextStyle(
                color: Colors.white,
                fontSize: r.isDesktop ? 20 : 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
