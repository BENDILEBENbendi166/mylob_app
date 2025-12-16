import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real user data from Firestore/Auth
    final user = {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'avatarUrl': 'https://via.placeholder.com/150'
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar + Name
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user['avatarUrl']!),
            ),
            const SizedBox(height: 12),
            Text(
              user['name']!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              user['email']!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),
            const Divider(),

            // Quick links
            _ProfileAction(
              icon: Icons.favorite,
              label: 'Favorites',
              onTap: () => context.go('/favorites'),
            ),
            _ProfileAction(
              icon: Icons.book_online,
              label: 'My Bookings',
              onTap: () => context.go('/reservation'),
            ),
            _ProfileAction(
              icon: Icons.settings,
              label: 'Settings',
              onTap: () => context.go('/settings'),
            ),

            const Divider(),

            // Logout
            _ProfileAction(
              icon: Icons.logout,
              label: 'Log Out',
              onTap: () {
                // TODO: implement logout logic
                context.go('/');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable action row
class _ProfileAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfileAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
