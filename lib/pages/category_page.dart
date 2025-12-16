import 'package:flutter/material.dart';
import 'package:mylob_app/screens/category_screen.dart';

class CategoryPage extends StatelessWidget {
  final String id;
  const CategoryPage({super.key, required this.id});
  @override
  Widget build(BuildContext context) => CategoryScreen(categoryId: id);
}
