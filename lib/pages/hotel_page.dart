import 'package:flutter/material.dart';
import 'package:mylob_app/screens/hotel_list_screen.dart';

class HotelPage extends StatelessWidget {
  final String id; // this is probably a cityId
  const HotelPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) => HotelListScreen(cityId: id);
}
