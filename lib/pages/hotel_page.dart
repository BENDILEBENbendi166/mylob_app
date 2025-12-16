import 'package:flutter/material.dart';
import 'package:mylob_app/screens/hotel_detail_screen.dart';

class HotelPage extends StatelessWidget {
  final String id;
  const HotelPage({super.key, required this.id});
  @override
  Widget build(BuildContext context) => HotelDetailScreen(hotelId: id);
}
