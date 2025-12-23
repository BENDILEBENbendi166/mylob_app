import 'package:flutter/material.dart';
import 'package:mylob_app/screens/city/city_screen.dart';

class CityPage extends StatelessWidget {
  final String id;
  const CityPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return CityScreen(cityId: id);
  }
}
