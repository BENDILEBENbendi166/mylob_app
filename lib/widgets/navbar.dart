import 'package:flutter/material.dart';
import 'package:mylob_app/main.dart';
class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    final _ = MediaQuery.of(context).size.width > 1100;

    return AppBar(
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
      title: TextButton(
        onPressed: () {},
        child: const Text(
          'Lobideyim',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        const _LanguageToggle(),
        _TopAction('Save Your Property', onPressed: () {
          Navigator.pushNamed(context, '/property');
        }),
        _TopAction('Sign Up', onPressed: () {
          Navigator.pushNamed(context, '/signup');
        }),
        _TopAction('Log In', onPressed: () {
          Navigator.pushNamed(context, '/log in');
        }),
      ],
    );
  }
}

class _TopAction extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  // ignore: unused_element
  const _TopAction(this.label, {super.key, this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: onPressed,
            icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
            label: Text(
              label,
              style: const TextStyle(
                color: Color.fromARGB(255, 243, 242, 243),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
}

// ignore: unused_element
class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Switch between English and Turkish
        final currentLocale = Localizations.localeOf(context);
        final newLocale = currentLocale.languageCode == 'en'
            ? const Locale('tr')
            : const Locale('en');
        myLob.setLocale(context, newLocale);
      },
      child: Text(
        Localizations.localeOf(context).languageCode == 'en'
            ? 'Türkçe'
            : 'English',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
