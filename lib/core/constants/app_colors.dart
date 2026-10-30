import 'package:flutter/material.dart';

/// Official FruitBari Design System Color Palette
/// Derived from the official FruitBari logo:
/// - Fresh Fruit Green (#16803C)
/// - Deep Brand Green (#0B5D2A)
/// - Vibrant Bari Orange (#F58220)
/// - Natural Basket Brown (#794628)
/// - Crisp Warm Background (#F8FAF5)
class AppColors {
  AppColors._();

  // Official Brand Primary Greens
  static const Color primary = Color(0xFF16803C); // Official FruitBari Leaf/Fruit Green
  static const Color primaryDark = Color(0xFF0B5D2A); // Deep Orchard Forest Green
  static const Color primaryLight = Color(0xFF2EA358); // Fresh leaf highlight
  static const Color primarySurface = Color(0xFFEAF5EC); // Subtle pale mint for badges & containers

  // Official Brand Secondary Oranges ("Bari")
  static const Color brandOrange = Color(0xFFF58220); // Vibrant FruitBari Orange
  static const Color accent = Color(0xFFF58220); // Golden Citrus / Ripe Mango
  static const Color accentWarm = Color(0xFFF58220); // Brand accent
  static const Color accentSubtle = Color(0xFFFFF3E6); // Warm orange tint for chips & badges

  // Natural Elements
  static const Color basketBrown = Color(0xFF794628); // Natural wicker basket brown
  static const Color freshGreen = Color(0xFF16803C);
  static const Color peakSeason = Color(0xFFE65100);
  static const Color organicTag = Color(0xFF059669);
  static const Color outOfStock = Color(0xFF9CA3AF);

  // Backgrounds & Surfaces
  static const Color scaffoldBackground = Color(0xFFF8FAF5); // Natural clean background
  static const Color cardBackground = Colors.white;
  static const Color surfaceElevated = Color(0xFFF0F4EC);
  static const Color divider = Color(0xFFE6EAE3);

  // Typography & Content
  static const Color textPrimary = Color(0xFF202820); // Deep botanical dark text
  static const Color textSecondary = Color(0xFF536253);
  static const Color textMuted = Color(0xFF879587);
  static const Color textOnPrimary = Colors.white;

  // Feedback
  static const Color error = Color(0xFFDC2626);
  static const Color success = Color(0xFF16803C);
  static const Color warning = Color(0xFFF58220);
}
