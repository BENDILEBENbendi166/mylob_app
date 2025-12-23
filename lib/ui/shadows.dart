import 'package:flutter/material.dart';
import 'package:mylob_app/ui/colors.dart';

/// App Shadow Definitions
/// Consistent shadow and glow effects
class AppShadows {
  // Standard elevation shadows
  static const List<BoxShadow> low = [
    BoxShadow(
      color: Color(0x1F000000), // 12% opacity black
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x14000000), // 8% opacity black
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];
  
  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color(0x1F000000), // 12% opacity black
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x14000000), // 8% opacity black
      offset: Offset(0, 4),
      blurRadius: 5,
      spreadRadius: 0,
    ),
  ];
  
  static const List<BoxShadow> high = [
    BoxShadow(
      color: Color(0x1F000000), // 12% opacity black
      offset: Offset(0, 4),
      blurRadius: 5,
      spreadRadius: -2,
    ),
    BoxShadow(
      color: Color(0x14000000), // 8% opacity black
      offset: Offset(0, 8),
      blurRadius: 10,
      spreadRadius: 1,
    ),
  ];
  
  static const List<BoxShadow> modal = [
    BoxShadow(
      color: Color(0x33000000), // 20% opacity black
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1F000000), // 12% opacity black
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: 2,
    ),
  ];
  
  // Glow effects
  static List<BoxShadow> glow({
    Color color = AppColors.primary,
    double opacity = 0.3,
    double blurRadius = 16.0,
  }) {
    return [
      BoxShadow(
        color: color.withOpacity(opacity),
        offset: const Offset(0, 0),
        blurRadius: blurRadius,
        spreadRadius: 0,
      ),
    ];
  }
  
  static List<BoxShadow> glowPrimary = [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.3),
      offset: const Offset(0, 0),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> glowSecondary = [
    BoxShadow(
      color: AppColors.secondary.withOpacity(0.3),
      offset: const Offset(0, 0),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> glowSuccess = [
    BoxShadow(
      color: AppColors.success.withOpacity(0.3),
      offset: const Offset(0, 0),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> glowError = [
    BoxShadow(
      color: AppColors.error.withOpacity(0.3),
      offset: const Offset(0, 0),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];
  
  // Inset shadows
  static const List<BoxShadow> inset = [
    BoxShadow(
      color: Color(0x14000000), // 8% opacity black
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
    ),
  ];
}
