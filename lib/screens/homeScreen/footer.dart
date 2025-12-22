import 'package:flutter/material.dart';

class FooterScreen extends StatelessWidget {
  const FooterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 10, 33, 87),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '© 2026 From Lobideyim.com . All rights reserved.',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.facebook),
                color: Colors.grey[600],
                tooltip: 'Facebook',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.link),
                color: Colors.grey[600],
                tooltip: 'LinkedIn',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.phone),
                color: Colors.grey[600],
                tooltip: 'Contact Us',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.email),
                color: Colors.grey[600],
                tooltip: 'Email Us',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.book_online),
                color: Colors.grey[600],
                tooltip: 'Book Now',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'About Us',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Terms of Service',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
