// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mylob_app/screens/homeScreen/home_screen.dart';
import 'package:mylob_app/screens/homeScreen/city_spotlight_carousel.dart';
import 'package:mylob_app/screens/homeScreen/deal_of_the_day.dart';
import 'package:mylob_app/screens/homeScreen/last_minute_deals_section.dart';
import 'package:mylob_app/screens/homeScreen/recommended_hotels_section.dart';
import 'package:mylob_app/screens/city/widgets/city_hero.dart';
import 'package:mylob_app/screens/city/widgets/attractions_grid.dart';
import 'package:mylob_app/screens/city/widgets/hotels_list.dart';

void main() {
  testWidgets('HomeScreen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify that the HomeScreen has a title.
    expect(find.text('Why Lobideyim.com?'), findsOneWidget);
  });

  testWidgets('CitySpotlightCarousel renders with loading state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CitySpotlightCarousel(
            cities: [],
            isLoading: true,
          ),
        ),
      ),
    );

    // Verify the title is present
    expect(find.text('Explore Cities'), findsOneWidget);
  });

  testWidgets('DealOfTheDay renders with loading state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DealOfTheDay(
            topDeal: null,
            hotel: null,
            isLoading: true,
          ),
        ),
      ),
    );

    // Verify the title is present
    expect(find.text('Deal of the Day'), findsOneWidget);
  });

  testWidgets('LastMinuteDealsSection renders with loading state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LastMinuteDealsSection(
            lastMinuteDeals: [],
            isLoading: true,
          ),
        ),
      ),
    );

    // Verify the title is present
    expect(find.text('Last Minute Deals'), findsOneWidget);
  });

  testWidgets('RecommendedHotelsSection renders with loading state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RecommendedHotelsSection(
            hotels: [],
            cities: [],
            isLoading: true,
          ),
        ),
      ),
    );

    // Verify the title is present
    expect(find.text('Recommended Hotels'), findsOneWidget);
  });

  testWidgets('CitySpotlightCarousel renders cities', (WidgetTester tester) async {
    final testCities = [
      {'id': '1', 'name': 'London', 'imageUrl': 'london.jpg', 'popularAttractions': []},
      {'id': '2', 'name': 'Paris', 'imageUrl': 'paris.jpg', 'popularAttractions': []},
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CitySpotlightCarousel(
            cities: testCities,
            isLoading: false,
          ),
        ),
      ),
    );

    // Wait for the carousel to render
    await tester.pumpAndSettle();

    // Verify cities are displayed
    expect(find.text('London'), findsOneWidget);
  });

  testWidgets('LastMinuteDealsSection displays empty state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LastMinuteDealsSection(
            lastMinuteDeals: [],
            isLoading: false,
          ),
        ),
      ),
    );

    // Wait for rendering
    await tester.pumpAndSettle();

    // Verify empty state message
    expect(find.text('No last minute deals available'), findsOneWidget);
  });

  testWidgets('DealOfTheDay displays deal information', (WidgetTester tester) async {
    final testDeal = {
      'category': 'Luxury Hotel',
      'discountPercent': 50,
      'hotelId': 'h1',
    };

    final testHotel = {
      'name': 'Grand Hotel',
      'stars': 5,
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DealOfTheDay(
            topDeal: testDeal,
            hotel: testHotel,
            isLoading: false,
          ),
        ),
      ),
    );

    // Wait for rendering
    await tester.pumpAndSettle();

    // Verify deal information is displayed
    expect(find.text('Luxury Hotel'), findsOneWidget);
    expect(find.text('Grand Hotel'), findsOneWidget);
    expect(find.text('50% OFF'), findsOneWidget);
  });

  // City Screen Widget Tests
  testWidgets('CityHero renders with loading state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CityHero(
            city: null,
            isLoading: true,
          ),
        ),
      ),
    );

    // Wait for rendering
    await tester.pumpAndSettle();

    // Verify skeleton is present
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('CityHero displays city information', (WidgetTester tester) async {
    final testCity = {
      'name': 'London',
      'country': 'United Kingdom',
      'imageUrl': 'london.jpg',
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CityHero(
            city: testCity,
            isLoading: false,
          ),
        ),
      ),
    );

    // Wait for rendering
    await tester.pumpAndSettle();

    // Verify city information is displayed
    expect(find.text('London'), findsOneWidget);
    expect(find.text('United Kingdom'), findsOneWidget);
  });

  testWidgets('PopularAttractionsGrid renders with loading state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PopularAttractionsGrid(
            attractions: [],
            isLoading: true,
          ),
        ),
      ),
    );

    // Verify the title is present
    expect(find.text('Popular Attractions'), findsOneWidget);
  });

  testWidgets('PopularAttractionsGrid displays attractions', (WidgetTester tester) async {
    final testAttractions = [
      {'name': 'Big Ben', 'latitude': 51.5007, 'longitude': -0.1246},
      {'name': 'Tower Bridge', 'latitude': 51.5055, 'longitude': -0.0754},
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PopularAttractionsGrid(
            attractions: testAttractions,
            isLoading: false,
          ),
        ),
      ),
    );

    // Wait for rendering
    await tester.pumpAndSettle();

    // Verify attractions are displayed
    expect(find.text('Big Ben'), findsOneWidget);
    expect(find.text('Tower Bridge'), findsOneWidget);
  });

  testWidgets('PopularAttractionsGrid shows empty state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PopularAttractionsGrid(
            attractions: [],
            isLoading: false,
          ),
        ),
      ),
    );

    // Wait for rendering
    await tester.pumpAndSettle();

    // Verify empty state message
    expect(find.text('No attractions available'), findsOneWidget);
  });

  testWidgets('HotelsInCityList renders with loading state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HotelsInCityList(
            hotels: [],
            city: null,
            isLoading: true,
          ),
        ),
      ),
    );

    // Verify the title is present (with "this city" as fallback)
    expect(find.textContaining('Hotels in'), findsOneWidget);
  });

  testWidgets('HotelsInCityList shows empty state', (WidgetTester tester) async {
    final testCity = {'name': 'Paris'};

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HotelsInCityList(
            hotels: [],
            city: testCity,
            isLoading: false,
          ),
        ),
      ),
    );

    // Wait for rendering
    await tester.pumpAndSettle();

    // Verify empty state message
    expect(find.text('No hotels found in this city'), findsOneWidget);
  });
}
