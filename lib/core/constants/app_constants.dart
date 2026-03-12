import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Dashboard Mahasiswa DATT';
  static const String appVersion = '1.0.0';

  // Keys
  static const String userPrefKey = 'user_prefs';

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;

  // Dashboard Gradient Colors
  static const List<List<Color>> dashboardGradients = [
    [Color(0xFFFF667eea), Color(0xFFFF764ba2)], // Purple
    [Color(0xFFFFf093fb), Color(0xFFFFf5576c)], // Pink
    [Color(0xFFFF4facfe), Color(0xFFFF00f2fe)], // Blue
    [Color(0xFFFF43e97b), Color(0xFFFF38f9d7)], // Green
  ];

  // Individual Gradient Colors (optional - for direct access)
  static const List<Color> gradientPurple = [
    Color(0xFFFF667eea),
    Color(0xFFFF764ba2),
  ];

  static const List<Color> gradientPink = [
    Color(0xFFFFf093fb),
    Color(0xFFFFf5576c),
  ];

  static const List<Color> gradientBlue = [
    Color(0xFFFF4facfe),
    Color(0xFFFF00f2fe),
  ];

  static const List<Color> gradientGreen = [
    Color(0xFFFF43e97b),
    Color(0xFFFF38f9d7),
  ];
}
