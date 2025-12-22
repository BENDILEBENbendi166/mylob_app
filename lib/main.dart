import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:mylob_app/pages/city_page.dart';
import 'package:mylob_app/pages/city_list_page.dart';
import 'package:mylob_app/pages/deal_list_page.dart';
import 'package:mylob_app/pages/favorites_page.dart';
import 'package:mylob_app/pages/home_page.dart';
import 'package:mylob_app/pages/hotel_page.dart';
import 'package:mylob_app/pages/login_page.dart';
import 'package:mylob_app/pages/profile_page.dart';
import 'package:mylob_app/pages/reservation_page.dart';
import 'package:mylob_app/pages/settings_page.dart';
import 'package:mylob_app/pages/signup_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const myLob());
}

// ignore: camel_case_types
class myLob extends StatelessWidget {
  const myLob({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const HomePage(),
        ),

        // ✅ Cities
        GoRoute(
          path: '/cities',
          builder: (_, __) => const CityListPage(),
        ),
        GoRoute(
          path: '/cities/:id',
          builder: (_, state) => CityPage(id: state.pathParameters['id']!),
        ),

        // ✅ Hotels
        GoRoute(
          path: '/hotel/:id',
          builder: (_, state) => HotelPage(id: state.pathParameters['id']!),
        ),

        // ✅ Deals
        GoRoute(
          path: '/deals/:hotelId',
          builder: (_, state) =>
              DealListPage(hotelId: state.pathParameters['hotelId']!),
        ),

        // ✅ Reservation
        GoRoute(
          path: '/reservation/:code',
          builder: (_, state) =>
              ReservationPage(code: state.pathParameters['code']!),
        ),

        // ✅ User
        GoRoute(path: '/favorites', builder: (_, __) => const FavoritesPage()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),

        // ✅ Auth
        GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
        GoRoute(path: '/signup', builder: (_, __) => const SignUpPage()),
      ],
    );

    return MaterialApp.router(
      title: 'Lobideyim',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 38, 56, 134),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }

  static void setLocale(BuildContext context, Locale newLocale) {}
}
