import 'package:flutter/material.dart';
import 'package:mylob_app/screens/deal_list_screen.dart';

class DealListPage extends StatelessWidget {
  final String hotelId;
  const DealListPage({super.key, required this.hotelId});
  @override
  Widget build(BuildContext context) => DealListScreen(hotelId: hotelId);
}
