import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static ColorScheme lightColorScheme() {
    return const ColorScheme.light(
      primary: Color(0xFFFFA500),
      background: Color(0xFFF2F2F2),
      surface: Color(0xFFF8F8F8),
      tertiary: Color(0xFF2FD78A),
    ).copyWith(
        onPrimary: const Color(0xFF303030),
        onSecondary: const Color(0xFF9C9C9C));
  }

  static ColorScheme darkColorScheme() {
    return const ColorScheme.dark(
      primary: Color(0xFFFFA500),
      background: Color(0xFF0E0F0E),
      surface: Color(0xFF171716),
      tertiary: Color(0xFF2FD78A),
    ).copyWith(
        onPrimary: const Color(0xFFFEFEFF),
        onSecondary: const Color(0xFFC3C2C3));
  }
}
