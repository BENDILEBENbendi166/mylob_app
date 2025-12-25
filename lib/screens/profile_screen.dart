import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mylob_app/screens/homeScreen/drawer.dart';

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
        centerTitle: true,
      ),
      drawer: const CustomDrawer(), // Add drawer for user-centric navigation
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile header
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user['avatarUrl']!),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user['name']!,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      user['email']!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Quick links
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _ProfileAction(
                    icon: Icons.favorite,
                    label: 'Favorites',
                    onTap: () => context.go('/favorites'),
                  ),
                  const Divider(height: 1),
                  _ProfileAction(
                    icon: Icons.book_online,
                    label: 'My Bookings',
                    onTap: () => context.go('/reservation'),
                  ),
                  const Divider(height: 1),
                  _ProfileAction(
                    icon: Icons.settings,
                    label: 'Settings',
                    onTap: () => context.go('/settings'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Logout
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: _ProfileAction(
                icon: Icons.logout,
                label: 'Log Out',
                onTap: () {
                  // TODO: implement logout logic
                  context.go('/');
                },
              ),
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
    final isLogout = label.toLowerCase().contains('log out');
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isLogout ? Colors.red : null,
          fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
