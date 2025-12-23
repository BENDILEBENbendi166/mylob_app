import 'package:flutter/material.dart';

/// App Color Palette
/// Consistent colors used throughout the app
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF1E88E5); // Blue
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF42A5F5);
  
  // Secondary colors
  static const Color secondary = Color(0xFFFF6F00); // Orange
  static const Color secondaryDark = Color(0xFFE65100);
  static const Color secondaryLight = Color(0xFFFF9800);
  
  // Accent colors
  static const Color accent = Color(0xFF00BCD4); // Cyan
  static const Color accentLight = Color(0xFF4DD0E1);
  
  // Semantic colors
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);
  
  static const Color error = Color(0xFFF44336); // Red
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFD32F2F);
  
  static const Color warning = Color(0xFFFFA726); // Amber
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);
  
  static const Color info = Color(0xFF2196F3); // Blue
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);
  
  // Neutral colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFFAFAFA);
  
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);
  
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFEEEEEE);
  
  // Gradients as color lists
  static const List<Color> primaryGradient = [
    Color(0xFF1E88E5),
    Color(0xFF1565C0),
  ];
  
  static const List<Color> secondaryGradient = [
    Color(0xFFFF6F00),
    Color(0xFFE65100),
  ];
  
  static const List<Color> successGradient = [
    Color(0xFF4CAF50),
    Color(0xFF388E3C),
  ];
  
  static const List<Color> heroGradient = [
    Color(0xFF1E88E5),
    Color(0xFF42A5F5),
  ];
  
  static const List<Color> dealGradient = [
    Color(0xFFFF6F00),
    Color(0xFFFF9800),
  ];
  
  // Dark theme colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2C);
  
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkDivider = Color(0xFF424242);
}
