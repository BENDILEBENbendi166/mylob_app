import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.hotel, size: 48, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 18),
                Text(
                  'Hotel Finder',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),

          // Favorites
          _DrawerItem(
            icon: Icons.favorite_outline_sharp,
            label: 'Favorites',
            onTap: () => context.go('/favorites'),
          ),

          // Bookings
          _DrawerItem(
            icon: Icons.book_online,
            label: 'Manage My Bookings',
            onTap: () => context.go('/reservation'),
          ),

          const Divider(),

          // Cities
          _DrawerItem(
            icon: Icons.location_city,
            label: 'Browse Cities',
            onTap: () => context.go('/cities'),
          ),

          // Deals
          _DrawerItem(
            icon: Icons.local_offer,
            label: 'Top Deals',
            onTap: () => context.go('/deals'),
          ),

          const Spacer(),

          // Settings
          _DrawerItem(
            icon: Icons.settings,
            label: 'Settings',
            onTap: () => context.go('/settings'),
          ),

          // Logout
          _DrawerItem(
            icon: Icons.logout,
            label: 'Log Out',
            onTap: () => context.go('/'),
          ),
        ],
      ),
    );
  }
}

// Reusable drawer item widget
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 24, color: Theme.of(context).colorScheme.onSurface),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      onTap: onTap,
    );
  }
}
