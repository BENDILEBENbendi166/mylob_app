import 'package:flutter/material.dart';

String assetImage(String filename) => 'assets/images/$filename';

Widget safeAssetImage(String filename, {BoxFit fit = BoxFit.cover}) {
  return Image.asset(
    assetImage(filename),
    fit: fit,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.broken_image);
    },
  );
}
