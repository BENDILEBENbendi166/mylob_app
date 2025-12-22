import 'package:flutter/material.dart';

String assetImage(String filename) {
  // Hotel images follow pattern c1.jpg, c2.jpg, c10.jpg
  final isHotel = RegExp(r'^c\d+\.jpg$').hasMatch(filename);

  if (isHotel) {
    return 'assets/images/hotels/$filename';
  } else {
    return 'assets/images/cities/$filename';
  }
}

Widget safeAssetImage(String filename, {BoxFit fit = BoxFit.cover}) {
  return Image.asset(
    assetImage(filename),
    fit: fit,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.broken_image);
    },
  );
}
