import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  Responsive(this.context);

  static Responsive of(BuildContext context) => Responsive(context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  bool get isMobile => width < 850;
  bool get isTablet => width >= 850 && width < 1100;
  bool get isDesktop => width >= 1100;

  // ✅ Unified spacing scale
  double get spacing => isDesktop
      ? 32
      : isTablet
          ? 24
          : 16;

  // ✅ Unified card image height
  double get cardImageHeight => isDesktop
      ? 240
      : isTablet
          ? 200
          : 160;

  // ✅ Unified grid columns
  int get gridColumns => isDesktop
      ? 4
      : isTablet
          ? 3
          : 2;

  // ✅ Unified page padding
  EdgeInsets get pagePadding =>
      EdgeInsets.symmetric(horizontal: spacing, vertical: spacing / 2);
}
