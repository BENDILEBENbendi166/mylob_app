import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mylob_app/services/city_service.dart';
import 'package:mylob_app/services/hotel_service.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:mylob_app/screens/city/widgets/city_hero.dart';
import 'package:mylob_app/screens/city/widgets/attractions_grid.dart';
import 'package:mylob_app/screens/city/widgets/hotels_list.dart';

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
    _citySub = CityService.streamCityById(widget.cityId).listen((cityData) {
      if (mounted) {
        setState(() {
          city = cityData;
          isLoading = false;
        });
        // Now that we have the city name, start listening for hotels in this city
        _hotelSub?.cancel();
        if (cityData != null && cityData['name'] != null) {
          _hotelSub = HotelService.streamHotelsByCity(cityData['name'])
              .listen((hotelList) {
            if (mounted) {
              setState(() {
                hotels = hotelList;
              });
            }
          });
        }
      }
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CityHero - Image + gradient + name
            CityHero(
              city: city,
              isLoading: isLoading,
            ),

            SizedBox(height: r.spacing * 2),

            // 2. PopularAttractionsGrid
            PopularAttractionsGrid(
              attractions: city?['popularAttractions'] ?? [],
              isLoading: isLoading,
            ),

            SizedBox(height: r.spacing * 2),

            // 3. HotelsInCityList
            HotelsInCityList(
              hotels: hotels,
              city: city,
              isLoading: isLoading,
            ),

            SizedBox(height: r.spacing * 2),
          ],
        ),
      ),
    );
  }
}
