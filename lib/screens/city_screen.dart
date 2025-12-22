import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mylob_app/services/city_service.dart';
import 'package:mylob_app/widgets/hotel_widget/hotel_card.dart';
import 'package:mylob_app/services/hotel_service.dart';
import 'package:mylob_app/utils/responsive.dart';

class CityScreen extends StatefulWidget {
  final String cityId;
  const CityScreen({super.key, required this.cityId});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  List<Map<String, dynamic>> hotels = [];
  Map<String, dynamic>? city;
  bool isLoading = true;

  StreamSubscription? _hotelSub;
  StreamSubscription? _citySub;

  @override
  void initState() {
    super.initState();
    _listenToStreams();
  }

  void _listenToStreams() {
    // ✅ Listen to hotels in this city
    _hotelSub =
        HotelService.streamHotelsByCity(widget.cityId).listen((hotelList) {
      setState(() {
        hotels = hotelList;
      });
    });

    // ✅ Listen to the specific city
    _citySub = CityService.streamCities(widget.cityId).listen((cityData) {
      setState(() {
        city = cityData as Map<String, dynamic>?;
        isLoading = false; // ✅ stop loading only when city is ready
      });
    });
  }

  @override
  void dispose() {
    _hotelSub?.cancel();
    _citySub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(city?['name'] ?? "Loading..."),
      ),
      body: Padding(
        padding: r.pagePadding,
        child: isLoading || city == null
            ? _buildSkeletonGrid(r)
            : hotels.isEmpty
                ? const Center(
                    child: Text(
                      'No hotels found in this city',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : _buildHotelGrid(r),
      ),
    );
  }

  Widget _buildSkeletonGrid(Responsive r) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: r.isMobile
            ? 1
            : r.isTablet
                ? 2
                : 3,
        childAspectRatio: r.isDesktop
            ? 1
            : r.isTablet
                ? 0.9
                : 0.8,
        crossAxisSpacing: r.spacing / 2,
        mainAxisSpacing: r.spacing / 2,
      ),
      itemCount: 6,
      itemBuilder: (_, __) => const HotelCard.skeleton(),
    );
  }

  Widget _buildHotelGrid(Responsive r) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: r.isMobile
            ? 1
            : r.isTablet
                ? 2
                : 3,
        childAspectRatio: r.isDesktop
            ? 1
            : r.isTablet
                ? 0.9
                : 0.8,
        crossAxisSpacing: r.spacing / 2,
        mainAxisSpacing: r.spacing / 2,
      ),
      itemCount: hotels.length,
      itemBuilder: (_, index) => HotelCard(
        hotel: hotels[index],
        city: city!,
      ),
    );
  }
}
