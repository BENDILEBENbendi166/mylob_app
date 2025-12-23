import 'package:flutter/material.dart';
import 'package:mylob_app/ui/colors.dart';

/// App Gradient Definitions
/// Consistent gradients used throughout the app
class AppGradients {
  // Primary gradients
  static const LinearGradient primary = LinearGradient(
    colors: AppColors.primaryGradient,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient primaryVertical = LinearGradient(
    colors: AppColors.primaryGradient,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient primaryHorizontal = LinearGradient(
    colors: AppColors.primaryGradient,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  // Secondary gradients
  static const LinearGradient secondary = LinearGradient(
    colors: AppColors.secondaryGradient,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryVertical = LinearGradient(
    colors: AppColors.secondaryGradient,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Success gradient
  static const LinearGradient success = LinearGradient(
    colors: AppColors.successGradient,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Hero screen gradients
  static const LinearGradient hero = LinearGradient(
    colors: AppColors.heroGradient,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient heroOverlay = LinearGradient(
    colors: [
      Color(0x99000000), // 60% opacity black
      Color(0x66000000), // 40% opacity black
      Colors.transparent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  
  // Card gradients
  static const LinearGradient cardSubtle = LinearGradient(
    colors: [
      Color(0xFFFAFAFA),
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardDeal = LinearGradient(
    colors: [
      Color(0xFFFFF3E0), // Light orange
      Color(0xFFFFFFFF), // White
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Button gradients
  static const LinearGradient buttonPrimary = LinearGradient(
    colors: AppColors.primaryGradient,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  static const LinearGradient buttonSuccess = LinearGradient(
    colors: AppColors.successGradient,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  static const LinearGradient buttonDeal = LinearGradient(
    colors: AppColors.dealGradient,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  // Shimmer gradient for loading states
  static const LinearGradient shimmer = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );
  
  // Background gradients
  static const LinearGradient backgroundLight = LinearGradient(
    colors: [
      Color(0xFFF5F5F5),
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient backgroundDark = LinearGradient(
    colors: [
      Color(0xFF121212),
      Color(0xFF1E1E1E),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
