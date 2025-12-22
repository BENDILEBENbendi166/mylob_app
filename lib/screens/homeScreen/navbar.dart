import 'package:flutter/material.dart';
import 'package:mylob_app/main.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavBar(
      {super.key, required Color backgroundColor, required Color iconColor});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 1100;

    return AppBar(
      automaticallyImplyLeading: !isWide, // ✅ hamburger only on mobile/tablet
      iconTheme: const IconThemeData(color: Colors.white),

      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 26, 74, 129),
              Color.fromARGB(255, 59, 51, 130),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),

      elevation: 0,

      title: InkWell(
        onTap: () => Navigator.pushNamed(context, '/'),
        child: const Text(
          'Lobideyim',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ✅ Desktop/tablet actions
      actions: isWide
          ? [
              const _LanguageToggle(),
              _TopAction(
                'Save Your Property',
                onPressed: () => Navigator.pushNamed(context, '/property'),
              ),
              _TopAction(
                'Sign Up',
                onPressed: () => Navigator.pushNamed(context, '/signup'),
              ),
              _TopAction(
                'Log In',
                onPressed: () => Navigator.pushNamed(context, '/login'),
              ),
              const SizedBox(width: 12),
            ]
          : null, // ✅ Mobile/tablet → actions hidden (drawer used instead)
    );
  }
}

class _TopAction extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  // ignore: unused_element_parameter
  const _TopAction(this.label, {required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.15),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle();

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    return TextButton(
      onPressed: () {
        final newLocale =
            locale == 'en' ? const Locale('tr') : const Locale('en');
        myLob.setLocale(context, newLocale);
      },
      child: Text(
        locale == 'en' ? 'Türkçe' : 'English',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
