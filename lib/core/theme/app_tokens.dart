import 'package:flutter/material.dart';

class AppTokens {
  AppTokens._();

  // =========================
  // PRIMARY COLORS
  // =========================
  static const Color primary900 = Color(0xFF0F2B5C);
  static const Color primary600 = Color(0xFF2563EB);
  static const Color primary50  = Color(0xFFEFF6FF);

  // =========================
  // NEUTRAL COLORS
  // =========================
  static const Color neutral50  = Color(0xFFF8FAFC);
  static const Color neutral300 = Color(0xFFE2E8F0);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);

  // =========================
  // SEMANTIC COLORS (IMPORTANT)
  // =========================
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error   = Color(0xFFEF4444);
  static const Color info    = Color(0xFF3B82F6);

  // =========================
  // GRADIENTS
  // =========================
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary900, primary600],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 168, 188, 231),
      Color(0xFF005C66),
    ],
  );

  // =========================
  // TYPOGRAPHY
  // =========================
  static const String fontFamily = 'Tajawal';

  static const TextStyle h1 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: neutral900,
    fontFamily: fontFamily,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: neutral900,
    fontFamily: fontFamily,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: neutral500,
    fontFamily: fontFamily,
  );

  // =========================
  // SPACING SYSTEM (IMPORTANT)
  // =========================
  static const double spaceXS = 4;
  static const double spaceSM = 8;
  static const double spaceMD = 16;
  static const double spaceLG = 24;
  static const double spaceXL = 32;

  // =========================
  // RADIUS
  // =========================
  static const double rSm = 6;
  static const double rMd = 10;
  static const double rLg = 16;
  static const double rXl = 24;

  // =========================
  // LOGO
  // =========================
  static const String logoPath = 'assets/images/logo.png';
}