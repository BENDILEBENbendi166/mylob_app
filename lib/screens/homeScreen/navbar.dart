import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mylob_app/main.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color iconColor;

  const CustomNavBar({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900;

    return AppBar(
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: iconColor),
      automaticallyImplyLeading: !isWide,
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
        onTap: () => context.go('/'),
        child: const Text(
          'Lobideyim',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: isWide
          ? [
              const _LanguageToggle(),
              _TopAction(
                'Save Your Property',
                onPressed: () => context.go('/property'),
              ),
              _TopAction(
                'Sign Up',
                onPressed: () => context.go('/signup'),
              ),
              _TopAction(
                'Log In',
                onPressed: () => context.go('/login'),
              ),
              const SizedBox(width: 12),
            ]
          : null,
    );
  }
}

class _TopAction extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _TopAction(this.label, {required this.onPressed});

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
        MyLob.setLocale(context, newLocale);
      },
      child: Text(
        locale == 'en' ? 'Türkçe' : 'English',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
